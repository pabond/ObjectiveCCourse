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

- (void)dealloc {
    self.mutableBuildings = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableBuildings = [NSMutableArray object];
    
    return self;
}

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
