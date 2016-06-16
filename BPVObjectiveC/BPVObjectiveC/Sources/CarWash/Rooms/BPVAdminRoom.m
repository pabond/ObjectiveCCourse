//
//  BPVAdminRoom.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAdminRoom.h"

#import "BPVWorker.h"
#import "BPVDirector.h"
#import "BPVWasher.h"
#import "BPVAccountant.h"

#import "NSObject+BPVExtensions.h"

static const NSUInteger kBPVWashersCount = 20;

@interface BPVAdminRoom ()
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

- (void)initWorkers;

@end

@implementation BPVAdminRoom

@dynamic workers;

#pragma mark -
#pragma mark Deallocation

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray object];
    [self initWorkers];
    
    return self;
}

- (void)initWorkers {
    for (NSUInteger iterator; iterator < kBPVWashersCount; iterator++) {
        [self.mutableWorkers addObject:[BPVWasher object]];
    }
    
    [self.mutableWorkers addObject:[BPVDirector object]];
    [self.mutableWorkers addObject:[BPVAccountant object]];
}

#pragma mark -
#pragma mark Public Implementation

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

- (void)addWorker:(id)worker {
    if (worker) {
        [self.mutableWorkers addObject:worker];
    }
}

- (void)removeWorker:(id)worker {
    [self.mutableWorkers removeObject:worker];
}

- (id)freeWorkerWithClass:(Class)cls {
    for (BPVWorker *worker in self.workers) {
        if (!worker.busy && [worker isKindOfClass:cls]) {
            return worker;
        }
    }
    
    return nil;
}

@end
