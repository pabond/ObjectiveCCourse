//
//  BPVCar.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"

@interface BPVCar ()
@property (nonatomic, assign) NSUInteger money;

@end

@implementation BPVCar

#pragma mark -
#pragma mark Initialisation

- (instancetype)init {
    self = [super init];
    self.money = kBPVCarWashPrice;
    
    return self;
}

#pragma mark -
#pragma mark accessors

#pragma mark -
#pragma mark BPVMoneyFlow

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

@end
