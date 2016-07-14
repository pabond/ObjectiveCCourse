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
    NSArray *cars = [NSArray arrayWithObjectsCount:40 usingBlock:^id() {    return [BPVCar object]; }];
    for (BPVCar *car in cars) {
        [self.complex washCar:car];
    }
}


@end
