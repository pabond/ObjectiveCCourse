//
//  BPVAccountant.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAccountant.h"

@implementation BPVAccountant

- (instancetype)init {
    self = [super init];
    self.position = BPVWorkerPositionAccountant;
    
    return self;
}

- (void)countMoney {
    NSLog(@"Accountant counting money");
}

@end
