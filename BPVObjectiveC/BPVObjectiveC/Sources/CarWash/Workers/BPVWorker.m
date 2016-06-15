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
@property (nonatomic, assign) NSUInteger selfMoney;

@end

@implementation BPVWorker

@dynamic money;

- (NSUInteger)money {
    return self.selfMoney;
}

#pragma marc
#pragma marc MoneyFlow

- (void)acceptMoney:(NSUInteger)value {
    self.selfMoney += value;
}

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.selfMoney = 0;
    
    return money;
}

- (void)takeMoneyFromObject:(id<BPVMoneyFlow>)object {
    [self acceptMoney:[object giveMoney]];
}

@end
