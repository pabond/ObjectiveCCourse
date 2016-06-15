//
//  BPVBuilding.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBuilding.h"

#import "BPVAdminRoom.h"

#import "NSObject+BPVExtensions.h"

@interface BPVBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation BPVBuilding

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
    [self.mutableRooms removeObject:room];
}

- (id)freeRoomWithClass:(Class)cls {
    for (BPVAdminRoom *room in self.mutableRooms) {
        if (!room.full && [room isKindOfClass:cls]) {
            return room;
        }
    }
    
    return nil;
}

@end
