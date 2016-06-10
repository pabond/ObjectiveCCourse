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

@end
