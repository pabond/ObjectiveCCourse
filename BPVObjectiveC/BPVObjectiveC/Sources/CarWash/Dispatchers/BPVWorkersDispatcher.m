//
//  BPVWorkersDispatcher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorkersDispatcher.h"

#import "BPVQueue.h"
#import "BPVWorker.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorkersDispatcher ()
@property (nonatomic, retain) NSMutableArray    *mutableProcessors;
@property (nonatomic, retain) BPVQueue          *objectsToProcess;
@property (nonatomic, retain) BPVQueue          *freeProcessors;

- (instancetype)initWithProcessors:(NSArray *)objects;

@end

@implementation BPVWorkersDispatcher

@dynamic processors;

#pragma mark -
#pragma mark Class methods

+ (instancetype)dispatcherWithProcessors:(NSArray *)processors {
    return [[[self alloc] initWithProcessors:processors] autorelease];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.objectsToProcess = nil;
    self.mutableProcessors = nil;
    self.freeProcessors = nil;
    
    [super dealloc];
}

- (instancetype)initWithProcessors:(NSArray *)objects {
    self = [super init];
    
    self.objectsToProcess = [BPVQueue object];
    self.mutableProcessors = [[objects mutableCopy] autorelease];
    
    BPVQueue *freeProcessors = [BPVQueue object];
    self.freeProcessors = freeProcessors;
    [freeProcessors enqueueObjects:objects];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)processors {
    @synchronized (self.mutableProcessors) {
        return [[self.mutableProcessors copy] autorelease];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)processObject:(id)object {
    if (object) {
        BPVWorker *worker = [self.freeProcessors dequeueObject];
        if (worker) {
            [worker processObject:object];
        } else {
            [self.objectsToProcess enqueueObject:object];
        }
    }
}

- (void)addProcessor:(id)processor {
    if (!processor) {
        return;
    }
    
    @synchronized (self.processors) {
        [self.mutableProcessors addObject:processor];
    }
}

- (void)removeProcessor:(id)processor {
    if (!processor) {
        return;
    }
    
    @synchronized (self.processors) {
        [self.mutableProcessors removeObject:processor];
    }
}

- (void)addProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }
    
    @synchronized (self.processors) {
        [self.mutableProcessors addObjectsFromArray:processors];
    }
}

- (void)removeProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }
    
    @synchronized (self.processors) {
        [self.mutableProcessors removeObjectsInArray:processors];
    }
}

#pragma mark -
#pragma mark BPVWorkersObserver

- (void)workerDidBecomeFree:(BPVWorker *)processor {
    id object = [processor.queue dequeueObject];
    if (object) {
        [processor processObject:object];
    } else {
        [self.freeProcessors enqueueObject:processor];
    }
}

@end
