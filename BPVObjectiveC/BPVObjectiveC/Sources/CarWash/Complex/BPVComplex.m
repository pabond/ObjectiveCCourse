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
#import "NSArray+BPVExtensions.h"

static const NSUInteger kBPVWashRoomsCount  = 20;
static const NSUInteger kBPVWashersCount  = 20;

@interface BPVComplex ()
@property (nonatomic, retain) BPVBuilding   *carWashBuilding;
@property (nonatomic, retain) BPVBuilding   *adminBuilding;
@property (nonatomic, retain) BPVQueue      *queue;

- (void)initInfrastructure;
- (void)initRooms;
- (void)initWorkers;

- (id)freeWasher;
- (id)freeAccountant;
- (id)freeDirector;

- (id)reservedFreeWorkerWithClass:(Class)class;
- (BPVBuilding *)buildingForWorkerWithClass:(Class)class;

- (BPVCarWashRoom *)freeCarWashRoom;

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
    
    [self initRooms];
    [self initWorkers];
}

- (void)initRooms {
    [self.adminBuilding addRoom:[BPVAdminRoom object]];
    for (NSUInteger iterator = 0; kBPVWashRoomsCount > iterator ; iterator++) {
        [self.carWashBuilding addRoom:[BPVCarWashRoom object]];
    }
}

- (void)initWorkers {
    BPVAdminRoom *adminRoom = [[self.adminBuilding rooms] firstObject];
    BPVDirector *director = [BPVDirector object];
    BPVAccountant *accountant = [BPVAccountant object];
    
    accountant.delegate = director;
    director.delegatingObject = accountant;
    
    [adminRoom addWorker:accountant];
    [adminRoom addWorker:director];
    
    BPVCarWashRoom *carWashRoom = [[self.carWashBuilding rooms] firstObject];
    for (NSUInteger iterator = 0; kBPVWashersCount > iterator; iterator++) {
        BPVWasher *washer = [BPVWasher object];
        [carWashRoom addWorker:washer];
        washer.delegate = accountant;
        accountant.delegatingObject = washer;
    }
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(BPVCar *)carToWash {
    BPVQueue *carsQueue = self.queue;
    [carsQueue enqueueObject:carToWash];

    BPVCar *car = nil;
    while ((car = [carsQueue dequeueObject])) {
        
        BPVWasher *washer = [self freeWasher];
            
        BPVCarWashRoom *washRoom = [self freeCarWashRoom];
        washRoom.car = car;
        
        [washer processObject:car];
        
        washRoom.car = nil;
    }
}

- (id)freeWasher {
    return [self reservedFreeWorkerWithClass:[BPVWasher class]];
}

- (id)freeAccountant {
    return [self reservedFreeWorkerWithClass:[BPVAccountant class]];
}

- (id)freeDirector {
    return [self reservedFreeWorkerWithClass:[BPVDirector class]];
}

- (id)reservedFreeWorkerWithClass:(Class)class {
    NSArray *workers = [[self buildingForWorkerWithClass:class] workersWithClass:class];
    workers = [workers filteredUsingBlock:^BOOL(BPVWorker *worker) { return !worker.busy; }];
    BPVWorker *freeWorker = [workers firstObject];
    
    freeWorker.busy = YES;
    
    return freeWorker;
}

- (BPVBuilding *)buildingForWorkerWithClass:(Class)class {
    return [class isSubclassOfClass:[BPVWasher class]] ? self.carWashBuilding : self.adminBuilding;
}

- (BPVCarWashRoom *)freeCarWashRoom {
    NSArray *rooms = [self.carWashBuilding roomsWithClass:[BPVCarWashRoom class]];
    rooms = [rooms filteredUsingBlock:^BOOL(BPVCarWashRoom *room) { return !room.car; }];
    
    return [rooms firstObject];
}

@end
