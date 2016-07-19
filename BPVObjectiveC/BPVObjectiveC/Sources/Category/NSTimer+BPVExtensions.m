//
//  NSTimer+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSTimer+BPVExtensions.h"

#import "NSObject+BPVExtensions.h"

typedef void (^BPVBlock)(void);


@implementation NSTimer (BPVExtensions)

#pragma mark -
#pragma mark Public implementations

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:((^)())block {
    if (!block) {
        return nil;
    }
    
    id object = [NSObject object];

    
    NSTimer *timer =[self scheduledTimerWithTimeInterval:interval
                                                  target:object
                                                selector:@selector()
                                                userInfo:nil
                                                 repeats:repeats];
    return timer;
}

#pragma mark -
#pragma mark Private implementations

@end
