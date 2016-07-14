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
    @synchronized (self) {
        if (object) {
            BPVWorker *worker = [self.freeProcessors dequeueObject];
            if (worker) {
                [self performSelectorInBackground:@selector(startProcessingObject:) withObject:object];
            } else {
                [self.objectsToProcess enqueueObject:object];
            }
        }
    }
}

- (void)addProcessor:(id)processor {
    [self.mutableProcessors addObject:processor];
}

- (void)removeProcessor:(id)processor {
    [self.mutableProcessors removeObject:processor];
}

- (void)addProcessors:(NSArray *)processors {
    [self.mutableProcessors addObjectsFromArray:processors];
}

- (void)removeProcessors:(NSArray *)processors {
    [self.mutableProcessors removeObjectsInArray:processors];
}


@end
