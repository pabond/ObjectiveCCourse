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

- (BOOL)containsProcessor:(id)processor;

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
    self.freeProcessors = nil;
    
    [self removeProcessors:self.processors];
    self.mutableProcessors = nil;
    
    [super dealloc];
}

- (instancetype)initWithProcessors:(NSArray *)processors {
    self = [super init];
    
    self.objectsToProcess = [BPVQueue object];
    
    self.mutableProcessors = [NSMutableArray array];
    [self addProcessors:processors];
    
    BPVQueue *freeProcessors = [BPVQueue object];
    self.freeProcessors = freeProcessors;
    [freeProcessors enqueueObjects:processors];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)processors {
    NSMutableArray *mutableProcessors = self.mutableProcessors;
    @synchronized (mutableProcessors) {
        return [[mutableProcessors copy] autorelease];
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
    
    NSMutableArray *mutableProcessors = self.mutableProcessors;
    @synchronized (mutableProcessors) {
        [mutableProcessors addObject:processor];
    }
}

- (void)removeProcessor:(id)processor {
    if (!processor) {
        return;
    }
    
    NSMutableArray *mutableProcessors = self.mutableProcessors;
    @synchronized (mutableProcessors) {
        [mutableProcessors removeObject:processor];
    }
}

- (void)addProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }

    @synchronized (self.mutableProcessors) {
        for (BPVWorker *processor in processors) {
            [processor addObserver:self];
    
            [self addProcessor:processor];
        }
    }
}

- (void)removeProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }
    
    for (BPVWorker *processor in processors) {
        [processor removeObserver:self];
        
        [self removeProcessor:processor];
    }
}

- (void)addFreeProcessorsQueue {
    [self.freeProcessors enqueueObjects:self.processors];
}

#pragma mark -
#pragma mark Private implementations

- (BOOL)containsProcessor:(id)processor {
    return [self.processors containsObject:processor];
}

#pragma mark -
#pragma mark BPVWorkersObserver methods

- (void)workerDidBecomeFree:(BPVWorker *)processor {
    @synchronized (self.mutableProcessors) {
        if ([self containsProcessor:processor]) {
            id object = [self.objectsToProcess dequeueObject];
            if (object) {
                [processor processObject:object];
            } else {
                [self.freeProcessors enqueueObject:processor];
            }
        }
    }
}

- (void)workerDidBecomeReadyForProcessing:(id)object {
    if (![self containsProcessor:object]) {
        [self processObject:object];
    }
}

@end
