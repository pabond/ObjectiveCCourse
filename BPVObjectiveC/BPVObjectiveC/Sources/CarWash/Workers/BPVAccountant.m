//
//  BPVAccountant.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAccountant.h"

@implementation BPVAccountant

- (void)countMoney {
    self.busy = YES;
    NSLog(@"Accountant counting money");
    self.busy = NO;
}

- (void)processObject:(id)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
}

@end
