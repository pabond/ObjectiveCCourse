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

@end

@implementation BPVWorker

@synthesize money = _money;
@synthesize busy = _busy;

#pragma marc
#pragma marc MoneyFlow

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
