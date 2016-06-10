//
//  BPVWasher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWasher.h"

@implementation BPVWasher

- (instancetype)init {
    self = [super init];
    self.position = BPVWorkerPositionWasher;
    
    return self;
}

- (void)washCar {
    NSLog(@"Washer washing car");
    NSLog(@"Car washed!");
}

@end
