//
//  BPVWasher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWasher.h"

#import "BPVCar.h"

static NSUInteger counter = 0;

@implementation BPVWasher

#pragma mark -
#pragma mark Public implementations

- (void)washCar:(BPVCar *)car {
    NSLog(@"%@ washing car", self.name);
}

- (void)performWorkWithObject:(id)object {
    [self washCar:object];
    [self takeMoneyFromObject:object];
}

- (void)finishProcessingObject:(BPVCar *)car {
    car.clean = YES;
    counter++;
    NSLog(@"Car %lu is cleaned by %@", counter, self.name);
}

@end
