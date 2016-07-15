//
//  BPVWorkersDispatcher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorkersDispatcher.h"

#import "BPVQueue.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorkersDispatcher ()
@property (nonatomic, retain) NSMutableArray    *mutableProcessors;
@property (nonatomic, retain) BPVQueue          *objectsToProcess;
@property (nonatomic, retain) BPVQueue          *freeProcessors;

- (BOOL)containsProcessor:(id)processor;

@end

@implementation BPVWorkersDispatcher

@dynamic processors;

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.objectsToProcess = nil;
    self.mutableProcessors = nil;
    self.freeProcessors = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    self.objectsToProcess = [BPVQueue object];
    self.mutableProcessors = [NSMutableArray array];
    self.freeProcessors = [BPVQueue object];
    
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
    
    @synchronized (self.mutableProcessors) {
        [self.mutableProcessors addObject:processor];
    }
}

- (void)removeProcessor:(id)processor {
    if (!processor) {
        return;
    }
    
    @synchronized (self.mutableProcessors) {
        [self.mutableProcessors removeObject:processor];
    }
}

- (void)addProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }
    
    @synchronized (self.mutableProcessors) {
        [self.mutableProcessors addObjectsFromArray:processors];
    }
}

- (void)removeProcessors:(NSArray *)processors {
    if (!processors) {
        return;
    }
    
    @synchronized (self.mutableProcessors) {
        [self.mutableProcessors removeObjectsInArray:processors];
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
    if ([self containsProcessor:processor]) {
        id object = [self.objectsToProcess dequeueObject];
        if (object) {
            [processor processObject:object];
        } else {
            [self.freeProcessors enqueueObject:processor];
        }
    }
}

- (void)workerDidBecomeReadyForProcessing:(id)object {
    if (![self containsProcessor:object]) {
        [self processObject:object];
    }
}

@end
