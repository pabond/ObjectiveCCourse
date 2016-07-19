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

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(SEL(^)())block {
    if (!block) {
        return nil;
    }
    
    id object = [NSObject object];
    SEL selectr = block();
    
    NSTimer *timer =[self scheduledTimerWithTimeInterval:interval
                                                  target:object
                                                selector:@selector(selectr)
                                                userInfo:nil
                                                 repeats:repeats];
    return timer;
}

#pragma mark -
#pragma mark Private implementations

@end
