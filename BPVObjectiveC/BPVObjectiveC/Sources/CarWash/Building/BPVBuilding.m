//
//  BPVBuilding.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBuilding.h"

#import "NSObject+BPVExtensions.h"
@interface BPVBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableBuildings;

@end

@implementation BPVBuilding

@dynamic buildings;

#pragma marc
#pragma marc Deallocation

- (void)dealloc {
    self.mutableBuildings = nil;
    
    [super dealloc];
}

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableBuildings = [NSMutableArray object];
    
    return self;
}

#pragma marc
#pragma marc Public Implementation

- (NSArray *)buildings {
    return [[self.mutableBuildings copy] autorelease];
}

- (void)addBuilding:(id)building {
    if (building) {
        [self.mutableBuildings addObject:building];
    }
}

- (void)removeBuilding:(id)building {
    if (building) {
        [self.mutableBuildings removeObject:building];
    }
}

@end
