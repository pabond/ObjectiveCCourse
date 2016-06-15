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
@property (nonatomic, assign) NSUInteger money;

@end

@implementation BPVCar

@synthesize money = _money;

#pragma marc
#pragma marc MoneyFlow

- (void)acceptMoney:(NSUInteger)value {
    self.money = self.money + value;
}

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

- (void)takeMoneyFromObject:(id<BPVMoneyFlow>)object {
    [self acceptMoney:[object giveMoney]];
}

@end
