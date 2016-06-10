//
//  BPVCar.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCar.h"

@implementation BPVCar

- (instancetype)init {
    self = [super init];
    self.clean = NO;
        
    return self;
}

- (void)acceptMoney {
    [self setMoney: self.money + kBPVCarWashPrice];
}

- (void)giveMoney {
    [self setMoney: self.money + kBPVCarWashPrice];
}

@end
