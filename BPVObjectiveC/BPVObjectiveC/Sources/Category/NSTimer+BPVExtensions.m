//
//  NSTimer+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSTimer+BPVExtensions.h"

#import "BPVSupportEntity.h"

#import "NSObject+BPVExtensions.h"

typedef void (^BPVBlock)(void);


@implementation NSTimer (BPVExtensions)

#pragma mark -
#pragma mark Public implementations

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void(^)())block {
    if (!block) {
        return nil;
    }
    
    id object = [BPVSupportEntity objectWithBlock:block];

    
    NSTimer *timer =[self scheduledTimerWithTimeInterval:interval
                                                  target:object
                                                selector:@selector(startTimer:)
                                                userInfo:nil
                                                 repeats:repeats];
    return timer;
}

#pragma mark -
#pragma mark Private implementations

@end
