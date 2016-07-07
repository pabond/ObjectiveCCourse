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
}

- (void)performWorkWithObject:(id)object {
    @synchronized (self) {
        sleep(1);
        [self washCar:object];
        [self takeMoneyFromObject:object];
    }
}

- (void)finishProcessingObject:(BPVCar *)car {
    car.clean = YES;
    NSLog(@"Car is clean");
}

@end
