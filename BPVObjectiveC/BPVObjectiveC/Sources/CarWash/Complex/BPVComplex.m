//
//  BPVComplex.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplex.h"

#import "BPVCarWashRoom.h"
#import "BPVWorker.h"
#import "BPVDirector.h"
#import "BPVAccountant.h"
#import "BPVWasher.h"
#import "BPVCar.h"

#import "BPVQueue.h"

#import "NSObject+BPVExtensions.h"

static const NSUInteger kBPVWashRoomsCount = 10;

@interface BPVComplex ()
@property (nonatomic, retain) BPVBuilding       *adminBuilding;
@property (nonatomic, retain) BPVBuilding       *carWashBuilding;
@property (nonatomic, retain) BPVQueue          *queue;

- (void)addCar:(BPVCar *)car;

- (id)freeWorker:(NSArray *)workers;
- (id)freeWashRoom:(NSArray *)rooms;

@end

@implementation BPVComplex

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.adminBuilding = nil;
    self.carWashBuilding = nil;
    self.queue = nil;
        
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.queue = [BPVQueue object];
    self.adminBuilding = [BPVBuilding object];
    self.carWashBuilding = [BPVBuilding object];
    [self.adminBuilding addRoom:[BPVAdminRoom object]];
    
    for (NSUInteger iterator = 0; kBPVWashRoomsCount > iterator ; iterator++) {
        [self.carWashBuilding addRoom:[BPVCarWashRoom object]];
    }
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCars {
    while (YES) {
        BPVCar *car = [self.queue deQueueNext];
        
        if (!car) {
            break;
        }
        
        BPVBuilding *adminBuilding = self.adminBuilding;
        BPVBuilding *carWashBuilding = self.carWashBuilding;
        
        BPVWasher *washer = [self freeWorker:[carWashBuilding workersWithClass:[BPVWasher class]]];
        BPVDirector *director = [self freeWorker:[adminBuilding workersWithClass:[BPVDirector class]]];
        BPVAccountant *accountant = [self freeWorker:[adminBuilding workersWithClass:[BPVAccountant class]]];
        
        washer.busy = YES;
        director.busy = YES;
        accountant.busy = YES;
        
        BPVCarWashRoom *washRoom = [self freeWashRoom:[carWashBuilding roomsWithClass:[BPVCarWashRoom class]]];
        washRoom.car = car;
        
        [washer processObject:car];
        [accountant processObject:washer];
        [director processObject:accountant];
        
        washer.busy = NO;
        director.busy = NO;
        accountant.busy = NO;
        
        washRoom.car = nil;
    }
}

#pragma mark -
#pragma mark Private Implementation

- (void)addCar:(BPVCar *)car {
    if (car && !car.isClean) {
        [self.queue inQueueObject:car];
    }
}

- (id)freeWorker:(NSArray *)workers {
    for (BPVWorker *worker in workers) {
        if (!worker.busy) {
            return worker;
        }
    }
    
    return nil;
}

- (id)freeWashRoom:(NSArray *)rooms {
    for (BPVCarWashRoom *room in rooms) {
        if (!room.car) {
            return room;
        }
    }
    
    return nil;
}

@end
