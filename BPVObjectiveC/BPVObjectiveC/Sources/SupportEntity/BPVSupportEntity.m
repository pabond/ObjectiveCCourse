//
//  BPVSupportEntity.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSupportEntity.h"

@interface BPVSupportEntity ()

- (instancetype)initWithBlock:(void(^)())block;

@end

@implementation BPVSupportEntity

#pragma mark -
#pragma mark Class methods

+ (instancetype)objectWithBlock:(void(^)())block {
    return [[[self alloc] initWithBlock:block] autorelease];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.block = nil;
    
    [super dealloc];
}

- (instancetype)initWithBlock:(void(^)())block {
    self = [super init];
    self.block = block;
    
    return self;
}


#pragma mark -
#pragma mark Public implementations

- (void)startTimer:(NSTimer *)timer {
    BPVSupportingBlock block = self.block;
    
    block();
}

@end
