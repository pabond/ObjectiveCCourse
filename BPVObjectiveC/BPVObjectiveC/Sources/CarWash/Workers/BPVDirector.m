//
//  BPVDirector.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVDirector.h"

#import "BPVAccountant.h"

@implementation BPVDirector

- (void)earnMoney {
    NSLog(@"Director earns money. Now director receive %lu", (unsigned long)self.money);
}

#pragma mark -
#pragma mark Public implementations

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self earnMoney];
    
    NSLog(@"Director processed accountant");
}

- (void)finishProcessing {
    [super finishProcessingObject:self];
}

@end
