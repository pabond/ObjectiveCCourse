//
//  BPVWasher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWasher.h"

#import "BPVCar.h"

@implementation BPVWasher

- (void)washCar:(BPVCar *)car {
    NSLog(@"Washer washing car");
    NSLog(@"Car washed!");
    car.clean = YES;
}

- (void)processObject:(id)object {
    [self washCar:object];
    [self takeMoneyFromObject:object];
    self.busy = NO;
}

@end
