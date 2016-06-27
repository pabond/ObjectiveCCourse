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
    NSLog(@"Accountant counting money");
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
}

#pragma mark -
#pragma mark BPVMoneyFlow

- (void)workerDidFinishProcessingObject:(id)worker {
    [self processObject:worker];
}

@end
