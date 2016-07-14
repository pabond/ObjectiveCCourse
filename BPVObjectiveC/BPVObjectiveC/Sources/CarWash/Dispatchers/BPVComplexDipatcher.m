//
//  BPVComplexDipatcher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplexDipatcher.h"

#import "BPVComplex.h"
#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

static const NSUInteger kBPVCarsCount = 40;

@interface BPVComplexDipatcher ()
@property (nonatomic, retain) BPVComplex *complex;

@end

@implementation BPVComplexDipatcher

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.complex = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.complex = [BPVComplex object];
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)washCars {
    BPVComplex *complex = self.complex;
    for (NSUInteger count = 0; count < kBPVCarsCount; count++) {
        [complex washCar:[BPVCar object]];
    }
    
    NSLog(@"%lu cars added pushed to wash", (unsigned long)kBPVCarsCount);
}


@end
