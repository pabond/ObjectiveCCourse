//
//  BPVWasher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWasher.h"

@implementation BPVWasher

- (void)washCar:(BPVCar *)car {
    NSLog(@"Washer washing car");
    NSLog(@"Car washed!");
    car.clean = YES;
}

@end
