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
    self.busy = YES;
    NSLog(@"Director earns money");
    self.busy = NO;
}

@end
