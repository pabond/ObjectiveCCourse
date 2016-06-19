//
//  BPVCarWashRoom.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCarWashRoom.h"
#import "BPVWasher.h"

#import "NSObject+BPVExtensions.h"

@implementation BPVCarWashRoom

#pragma mark - 
#pragma mark Deallocation / Initalisation

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self addWorker:[BPVWasher object]];
    
    return self;
}

@end
