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

@interface BPVAdminRoom ()
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation BPVAdminRoom

@dynamic workers;

#pragma marc
#pragma marc Deallocation

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray object];
    
    return self;
}

#pragma marc
#pragma marc Public Implementation

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
