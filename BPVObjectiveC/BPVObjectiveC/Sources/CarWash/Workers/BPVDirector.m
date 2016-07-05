//
//  BPVDirector.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVDirector.h"

#import "BPVAccountant.h"

@interface BPVDirector ()

- (void)changeSelfState;

@end

@implementation BPVDirector

- (void)earnMoney {
    NSLog(@"Director earns money. Now director receive %lu", (unsigned long)self.money);
}

#pragma mark -
#pragma mark Public implementations

- (void)processObject:(id)object {
    [super processObject:object];
    [self changeSelfState];
}

- (void)performWorkWithObject:(id)object {
    [self takeMoneyFromObject:object];
    [self earnMoney];
}

#pragma mark -
#pragma mark BPVWorkersDelegate

- (void)workerDidBecomeReadyForProcessing:(id)accountant {
    [self processObject:accountant];
}

#pragma mark -
#pragma mark Private implementations

- (void)changeSelfState {
    self.state = BPVWorkerStateFree;
}

@end
