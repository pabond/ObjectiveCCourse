//
//  BPVWorker.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorker ()

@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation BPVWorker

@synthesize money;

@dynamic workers;

- (void)dealloc {
    self.mutableWorkers = nil;
    self.responsibility = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableWorkers = [NSMutableArray object];
    
    return self;
}

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

- (void)addWorker:(id)worker {
    if (worker) {
        [self.mutableWorkers addObject:worker];
    }
}

- (void)removeWorker:(id)worker {
    if (worker) {
        [self.mutableWorkers removeObject:worker];
    }
}

- (void)acceptMoney {
    [self setMoney: self.money + kBPVCarWashPrice];
}

- (void)giveMoney {
    [self setMoney: self.money + kBPVCarWashPrice];
}

- (void)setMoney:(NSUInteger)value {
    _money += value;
}

- (NSUInteger)money {
    return _money;
}

@end
