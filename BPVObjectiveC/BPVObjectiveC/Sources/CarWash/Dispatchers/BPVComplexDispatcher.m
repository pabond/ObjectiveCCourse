//
//  BPVComplexDispatcher.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplexDispatcher.h"

#import "BPVComplex.h"
#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

static const NSUInteger kBPVCarsCount = 40;

@interface BPVComplexDispatcher ()
@property (nonatomic, retain) BPVComplex *complex;

- (instancetype)initWithComplex:(BPVComplex *)complex;

@end

@implementation BPVComplexDispatcher

#pragma mark -
#pragma mark Class methods

+ (instancetype)disptcherWithComplex:(BPVComplex *)complex {
    return [[[self alloc] initWithComplex:complex] autorelease];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.complex = nil;
    
    [super dealloc];
}

- (instancetype)initWithComplex:(BPVComplex *)complex {
    self = [super init];
    self.complex = complex;
    
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
