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

@synthesize money = _money;

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
    if (worker) {
        [self.mutableWorkers removeObject:worker];
    }
}

#pragma marc
#pragma marc <MoneyFlow> property accesors

- (void)setMoney:(NSUInteger)value {
    _money = value;
}

- (NSUInteger)money {
    return _money;
}

#pragma marc
#pragma marc <MoneyFlow> Implementation

- (void)acceptMoney:(NSUInteger)value {
    self.money = self.money + value;
}

- (NSUInteger)giveMoney {
    return self.money;;
}

- (void)takeMoney:(id<BPVMoneyFlow>)object {
    [self acceptMoney:[object giveMoney]];
}

@end
