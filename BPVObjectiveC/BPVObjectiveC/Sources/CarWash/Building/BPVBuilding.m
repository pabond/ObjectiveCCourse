//
//  BPVBuilding.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBuilding.h"

#import "BPVAdminRoom.h"
#import "BPVCarWashRoom.h"

#import "NSObject+BPVExtensions.h"

static const NSUInteger kBPVWashRoomsCount = 20;

@interface BPVBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

- (void)initRooms;

@end

@implementation BPVBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Deallocation

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    [self initRooms];
    
    return self;
}

- (void)initRooms {
    for (NSUInteger iterator = 0; iterator < kBPVWashRoomsCount; iterator++) {
        self.mutableRooms[iterator] = [BPVCarWashRoom object];
    }
    
    [self.mutableRooms addObject:[BPVAdminRoom object]];
}

#pragma mark -
#pragma mark Public Implementation

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

- (id)roomWithClass:(Class)cls {
    for (BPVAdminRoom *room in self.rooms) {
        if (!room.full && [room isKindOfClass:cls]) {
            return room;
        }
    }
    
    return nil;
}

- (id)workersWithClass:(Class)cls {
    BPVAdminRoom *adminRoom = [self roomWithClass:BPV]
    for (BPVWorker *worker in self.workers) {
        if (!worker.busy && [worker :cls]) {
            return worker;
        }
    }
}

@end
