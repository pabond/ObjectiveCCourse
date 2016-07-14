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

#pragma mark -
#pragma mark BPVMoneyFlow

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
    
    NSLog(@"Accountant take money from washer %@", object);
}

@end

