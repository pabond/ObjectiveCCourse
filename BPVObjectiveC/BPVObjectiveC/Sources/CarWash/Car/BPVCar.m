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

@synthesize money;

@dynamic cars;

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.clean = NO;
    self.mutableCars = [NSMutableArray object];
        
    return self;
}

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
