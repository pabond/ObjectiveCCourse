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

#import "BPVGCD.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"
#import "NSTimer+BPVExtensions.h"

static const NSUInteger kBPVCarsCount           = 40;
static const uint8_t    kBPVInterval            = 5;
static const size_t     kBPVIterationsCount     = 10;

@interface BPVComplexDispatcher ()
@property (nonatomic, retain) BPVComplex    *complex;
@property (nonatomic, assign) NSTimer       *timer;

- (instancetype)initWithComplex:(BPVComplex *)complex;

- (void)stopTimer;
- (void)startTimer;

@end

@implementation BPVComplexDispatcher

@dynamic running;

#pragma mark -
#pragma mark Class methods

+ (instancetype)disptcherWithComplex:(BPVComplex *)complex {
    return [[[self alloc] initWithComplex:complex] autorelease];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.timer = nil;
    self.complex = nil;
    
    [super dealloc];
}

- (instancetype)initWithComplex:(BPVComplex *)complex {
    self = [super init];
    self.complex = complex;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
    if (_timer != timer) {
        [_timer invalidate];
        
        _timer = timer;
    }
}

- (void)setRunning:(BOOL)running {
    SEL selector = running ? @selector(startTimer) : @selector(stopTimer);
    [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
}

- (BOOL)isRunning {
    return nil != self.timer;
}

#pragma mark -
#pragma mark Public implementations

- (void)washCars {
    BPVComplex *complex = self.complex;
    for (NSUInteger count = 0; count < kBPVCarsCount; count++) {
        [complex performSelectorInBackground:@selector(washCar:) withObject:[BPVCar object]];
    }
    
    NSLog(@"%lu cars added pushed to wash", (unsigned long)kBPVCarsCount);
}

- (void)stopTimer {
    self.timer = nil;
}

- (void)startTimer {
    self.timer = [NSTimer timerWithTimeInterval:kBPVInterval repeats:YES block:^(void){ [self washCars]; }];
}

//    dispatch_apply(kBPVIterationsCount, BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityBackground), ^(size_t count) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBPVInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self washCars];
//        });
//    });
//    
//    self.running = NO;

@end
