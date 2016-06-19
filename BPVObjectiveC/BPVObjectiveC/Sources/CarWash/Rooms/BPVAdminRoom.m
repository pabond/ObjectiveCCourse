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

- (void)initWorkers;

@end

@implementation BPVAdminRoom

@dynamic workers;

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray object];
    [self initWorkers];
    
    return self;
}

- (void)initWorkers {
    [self addWorker:[BPVDirector object]];
    [self addWorker:[BPVAccountant object]];
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

- (NSArray *)workersWithClass:(Class)cls {
    NSMutableArray *workers = [NSMutableArray array];
    for (BPVWorker *worker in self.workers) {
        if ([worker isMemberOfClass:cls]) {
            [workers addObject:worker];
        }
    }
    
    return [[workers copy] autorelease];
}

@end
