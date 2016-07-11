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

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (void)washCar:(BPVCar *)car {
    NSLog(@"Washer washing car");
    NSLog(@"Car washed!");
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
