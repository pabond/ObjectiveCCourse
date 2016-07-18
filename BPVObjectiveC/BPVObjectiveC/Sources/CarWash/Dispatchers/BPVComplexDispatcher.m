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
static const uint8_t kBPVInterval = 5;

@interface BPVComplexDispatcher ()
@property (nonatomic, retain) BPVComplex    *complex;
@property (nonatomic, assign) NSTimer       *timer;
@property (nonatomic, assign, getter=isRunning) BOOL running;

- (instancetype)initWithComplex:(BPVComplex *)complex;

- (void)offTimer;
- (void)onTimer;

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
        [self.timer invalidate];
        
        _timer = timer;
    }
}

- (void)setRunning:(BOOL)running {
    SEL selector = running ? @selector(onTimer) : @selector(offTimer);
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

- (void)offTimer {
    self.timer = nil;
}

- (void)onTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kBPVInterval
                                                  target:self
                                                selector:@selector(washCars)
                                                userInfo:nil
                                                 repeats:YES];
}

@end
