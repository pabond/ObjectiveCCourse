//
//  BPVSupportEntity.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSupportEntity.h"

@interface BPVSupportEntity ()

- (instancetype)initWithBlock:(void(^)())block object:(BPVComplexDispatcher *)object;

@end

@implementation BPVSupportEntity

#pragma mark -
#pragma mark Class methods

+ (instancetype)objectWithBlock:(void(^)())block object:(BPVComplexDispatcher *)object; {
    return [[[self alloc] initWithBlock:block object:object] autorelease];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (void)dealloc {
    self.block = nil;
    self.object = nil;
    
    [super dealloc];
}

- (instancetype)initWithBlock:(void(^)())block object:(BPVComplexDispatcher *)object {
    self = [super init];
    self.block = block;
    self.object = object;
    
    return self;
}


#pragma mark -
#pragma mark Public implementations

- (void)performBlock {
    self.block();
}

@end
