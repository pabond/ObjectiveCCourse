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
    NSLog(@"%@ counting money", self.name);
}

#pragma mark -
#pragma mark BPVMoneyFlow

- (void)performWorkWithObject:(BPVWorker *)object {
    [self takeMoneyFromObject:object];
    [self countMoney];
    
    NSLog(@"%@ take money from %@", self.name, object.name);
}

@end

