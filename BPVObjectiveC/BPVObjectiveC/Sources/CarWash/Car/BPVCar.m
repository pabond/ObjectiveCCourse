//
//  BPVCar.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"

@interface BPVCar ()
@property (nonatomic, retain) NSMutableArray *mutableCars;

@end

@implementation BPVCar

@synthesize money = _money;

@dynamic cars;

#pragma marc
#pragma marc Deallocation

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.clean = NO;
    self.mutableCars = [NSMutableArray object];
        
    return self;
}

#pragma marc
#pragma marc Public Implementation

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

- (void)addCar:(id)car {
    if (car) {
        [self.mutableCars addObject:car];
    }
}

- (void)removeCar:(id)car {
    if (car) {
        [self.mutableCars removeObject:car];
    }
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

#pragma marc
#pragma marc <MoneyFlow> property accesors

- (void)setMoney:(NSUInteger)value {
    _money += value;
}

- (NSUInteger)money {
    return _money;
}

@end
