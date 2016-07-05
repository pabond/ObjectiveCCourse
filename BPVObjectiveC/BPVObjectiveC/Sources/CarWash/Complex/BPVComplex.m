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

#import "BPVObservableObject.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

static const NSUInteger kBPVWashRoomsCount  = 20;
static const NSUInteger kBPVWashersCount  = 20;

@interface BPVComplex ()
@property (nonatomic, retain) BPVBuilding   *carWashBuilding;
@property (nonatomic, retain) BPVBuilding   *adminBuilding;
@property (nonatomic, retain) BPVQueue      *carsQueue;
@property (nonatomic, retain) BPVQueue      *freeWashersQueue;

- (void)initInfrastructure;
- (void)initRooms;
- (void)initWorkers;

- (id)freeWasher;
- (id)freeAccountant;
- (id)freeDirector;

- (id)reservedFreeWorkerWithClass:(Class)class;
- (BPVBuilding *)buildingForWorkerWithClass:(Class)class;

- (BPVCarWashRoom *)freeCarWashRoom;

- (void)removeWorkersObservers;
- (NSArray *)allWorkers;

@end

@implementation BPVComplex

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    [self removeWorkersObservers];
    
    self.adminBuilding = nil;
    self.carWashBuilding = nil;
    self.carsQueue = nil;
    self.freeWashersQueue = nil;
        
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.carsQueue = [BPVQueue object];
    self.freeWashersQueue = [BPVQueue object];
    self.adminBuilding = [BPVBuilding object];
    self.carWashBuilding = [BPVBuilding object];
    
    [self initRooms];
    [self initWorkers];
}

- (void)initRooms {
    [self.adminBuilding addRoom:[BPVAdminRoom object]];
    BPVBuilding *carWashBuilding = self.carWashBuilding;
    for (NSUInteger iterator = 0; iterator < kBPVWashRoomsCount; iterator++) {
        [carWashBuilding addRoom:[BPVCarWashRoom object]];
    }
}

- (void)initWorkers {
    BPVAdminRoom *adminRoom = [[self.adminBuilding rooms] firstObject];
    BPVDirector *director = [BPVDirector object];
    BPVAccountant *accountant = [BPVAccountant object];
    
    [accountant addObserver:director];
    
    [adminRoom addWorker:accountant];
    [adminRoom addWorker:director];
    
    BPVCarWashRoom *carWashRoom = [[self.carWashBuilding rooms] firstObject];
    for (NSUInteger iterator = 0; kBPVWashersCount > iterator; iterator++) {
        BPVWasher *washer = [BPVWasher object];
        [carWashRoom addWorker:washer];
        [washer addObservers:@[accountant, self]];
    }
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(BPVCar *)carToWash {
    BPVQueue *carsQueue = self.carsQueue;
    [carsQueue enqueueObject:carToWash];
    
    BPVWasher *washer = nil;
    BPVCarWashRoom *washRoom = nil;

    BPVCar *car = nil;
    while ((car = [carsQueue dequeueObject])) {
        washer = [self freeWasher];
        washRoom = [self freeCarWashRoom];
        
        washRoom.car = car;
        [washer processObject:car];
        washRoom.car = nil;
    }
}

- (void)removeWorkersObservers {
    for (BPVWorker *worker in [self allWorkers]) {
        [worker removeObservers];
    }
}

- (NSArray *)allWorkers {
    NSMutableArray *workers = [NSMutableArray array];
    BPVBuilding *adminBuilding = self.adminBuilding;
    [workers addObjectsFromArray:[adminBuilding workersWithClass:[BPVAccountant class]]];
    [workers addObjectsFromArray:[adminBuilding workersWithClass:[BPVDirector class]]];
    [workers addObjectsFromArray:[self.carWashBuilding workersWithClass:[BPVWasher class]]];
    
    return [[workers copy] autorelease];
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
    workers = [workers filteredUsingBlock:^BOOL(BPVWorker *worker) { return BPVWorkerStateFree == worker.state; }];
    BPVWorker *freeWorker = [workers firstObject];
    
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

#pragma mark -
#pragma mark BPVWorkersDelegate

- (void)workerDidBecomeFree:(BPVWorker *)worker {
    [self.freeWashersQueue enqueueObject:worker];
}

@end
