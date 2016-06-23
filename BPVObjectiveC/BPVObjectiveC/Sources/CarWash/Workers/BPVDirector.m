//
//  BPVDirector.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVDirector.h"

@implementation BPVDirector

- (void)earnMoney {
    NSLog(@"Director earns money. Now director receive %lu", (unsigned long)self.money);
}

- (void)processObject:(id)object {
    [self takeMoneyFromObject:object];
    [self earnMoney];
    self.busy = NO;
}

@end
