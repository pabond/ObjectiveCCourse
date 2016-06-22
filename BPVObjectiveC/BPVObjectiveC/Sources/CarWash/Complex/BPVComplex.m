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

static const NSUInteger kBPVWashRoomsCount  = 10;

@interface BPVComplex ()
@property (nonatomic, retain) BPVBuilding   *carWashBuilding;
@property (nonatomic, retain) BPVBuilding   *adminBuilding;
@property (nonatomic, retain) BPVQueue      *queue;

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
    
    BPVAdminRoom *adminRoom = [BPVAdminRoom object];
    [self.adminBuilding addRoom:adminRoom];
    
    [adminRoom addWorker:[BPVDirector object]];
    [adminRoom addWorker:[BPVAccountant object]];
    
    for (NSUInteger iterator = 0; kBPVWashRoomsCount > iterator ; iterator++) {
        BPVCarWashRoom *carWashRoom = [BPVCarWashRoom object];
        [self.carWashBuilding addRoom:carWashRoom];
        [carWashRoom addWorker:[BPVWasher object]];
    }
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(BPVCar *)carToWash {
    BPVQueue *carsQueue = self.queue;
    [carsQueue enqueueObject:carToWash];

    BPVCar *car = nil;
    while ((car = [carsQueue dequeueObject])) {
        
        BPVWasher *washer = [self reservedFreeWorkerWithClass:[BPVWasher class]];
        BPVDirector *director = [self reservedFreeWorkerWithClass:[BPVDirector class]];
        BPVAccountant *accountant = [self reservedFreeWorkerWithClass:[BPVAccountant class]];
            
        BPVCarWashRoom *washRoom = [self freeCarWashRoom];
        
        washRoom.car = car;
        
        [washer processObject:car];
        [accountant processObject:washer];
        [director processObject:accountant];
        
        washRoom.car = nil;
    }
}

- (id)reservedFreeWorkerWithClass:(Class)class {
    NSArray *workres = [[self buildingForWorkerWithClass:class] workersWithClass:class];
    BPVWorker *freeWorker = [[workres filteredArrayUsingPredicate:[self freeWorkerPredicate]] firstObject];
    
    freeWorker.busy = YES;
    
    return freeWorker;
}

- (BPVBuilding *)buildingForWorkerWithClass:(Class)class {
    return [class isSubclassOfClass:[BPVWasher class]] ? self.carWashBuilding : self.adminBuilding;
}

- (NSPredicate *)freeWorkerPredicate {
    return [NSPredicate predicateWithBlock:^BOOL(BPVWorker *worker, NSDictionary *bindings) { return !worker.busy; }];
}

- (BPVCarWashRoom *)freeCarWashRoom {
    NSArray *rooms = [self.carWashBuilding roomsWithClass:[BPVCarWashRoom class]];
    BPVCarWashRoom * freeWashRoom = [[rooms filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(BPVCarWashRoom *room, NSDictionary *bindings) { return !room.car; }]] firstObject];
    
    return freeWashRoom;
}

@end
