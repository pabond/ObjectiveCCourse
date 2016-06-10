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
@property (nonatomic, retain) NSMutableArray *mutableWorkers;

@end

@implementation BPVAdminRoom

@dynamic rooms;
@dynamic workers;

- (void)dealloc {
    self.mutableWorkers = nil;
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableRooms = [NSMutableArray object];
    self.mutableWorkers = [NSMutableArray object];
    
    return self;
}

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
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

- (void)addWorker:(id)worker {
    if (worker) {
        [self.mutableWorkers addObject:worker];
    }
}

- (void)removeWorker:(id)worker {
    if (worker) {
        [self.mutableWorkers removeObject:worker];
    }
}

@end
