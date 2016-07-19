//
//  NSTimer+BPVExtensions.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BPVExtensions)

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:((^)())block;

@end
