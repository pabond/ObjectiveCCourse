//
//  NSObject+BPVExtensions.m
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSObject+BPVExtensions.h"

@implementation NSObject (BPVExtensions)

+ (id)object {
    return [[[self alloc] init] autorelease];
}

- (void)performSelectorOnMainThreadWithoutObject:(SEL)aSelector
                                   waitUntilDone:(BOOL)wait
{
    [self performSelectorOnMainThread:aSelector
                           withObject:nil
                        waitUntilDone:wait];
}

@end
