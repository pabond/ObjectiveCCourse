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

@interface BPVBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation BPVBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Deallocation/Initialisation

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];

    return self;
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

- (NSArray *)roomsWithClass:(Class)class {
    NSMutableArray *rooms = [NSMutableArray object];
    for (BPVCarWashRoom *room in self.rooms) {
        if ([rooms isMemberOfClass:class])
            [rooms addObject:room];
    }
    
    return rooms;
}

- (NSArray *)workersWithClass:(Class)class {
    NSMutableArray *workers = [NSMutableArray object];
    for (BPVAdminRoom *room in self.rooms) {
        [workers addObjectsFromArray:[room workersWithClass:class]];
    }
    
    return [[workers copy] autorelease];
}

@end
