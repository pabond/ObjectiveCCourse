//
//  BPVAdminRoom.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAdminRoom.h"

#import "NSObject+BPVExtensions.h"

@interface BPVAdminRoom ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation BPVAdminRoom

@dynamic rooms;

#pragma marc
#pragma marc Deallocation

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    
    return self;
}

#pragma marc
#pragma marc Public Implementation

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

- (void)addRoom:(id)room {
    if (room) {
        [self.mutableRooms addObject:room];
    }
}

- (void)removeRoom:(id)room {
    if (room) {
        [self.mutableRooms removeObject:room];
    }
}

@end
