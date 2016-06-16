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
@property (nonatomic, assign) NSUInteger selfMoney;

@end

@implementation BPVCar

@dynamic money;

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.selfMoney = kBPVCarWashPrice;
    
    return self;
}

#pragma marc
#pragma marc accessors

- (NSUInteger)money {
    return self.selfMoney;
}

#pragma marc
#pragma marc MoneyFlow

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.selfMoney = 0;
    
    return money;
}

@end
