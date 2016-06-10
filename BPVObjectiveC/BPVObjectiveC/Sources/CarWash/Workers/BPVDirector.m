//
//  BPVDirector.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVDirector.h"

@implementation BPVDirector

- (instancetype)init {
    self = [super init];
    self.position = BPVWorkerPositionDirector;
    
    return self;
}

- (void)earnMoney {
    NSLog(@"Director earns money");
}

@end
