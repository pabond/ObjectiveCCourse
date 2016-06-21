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
static const NSUInteger kBPVCarsCount       = 40;

@interface BPVComplex ()
@property (nonatomic, retain) BPVBuilding   *adminBuilding;
@property (nonatomic, retain) BPVBuilding   *carWashBuilding;
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

- (void)washCars {
    BPVQueue *carsQueue = self.queue;
    for (NSUInteger count = 0; count < kBPVCarsCount; count++) {
        [carsQueue inQueueObject:[BPVCar object]];
    }
    
    while (YES) {
        BPVCar *car = [carsQueue deQueueNext];
        
        if (!car) {
            break;
        }
        
        BPVBuilding *adminBuilding = self.adminBuilding;
        BPVBuilding *carWashBuilding = self.carWashBuilding;
        
        NSPredicate *freeObjectsPredicate = [NSPredicate predicateWithBlock:
                                             ^BOOL(BPVWorker *worker, NSDictionary *bindings) {
                                                 return !worker.busy;
                                             }];
        
        BPVWasher *washer = [[[carWashBuilding workersWithClass:[BPVWasher class]] filteredArrayUsingPredicate:freeObjectsPredicate] firstObject];
        
        BPVDirector *director = [[[adminBuilding workersWithClass:[BPVDirector class]] filteredArrayUsingPredicate:freeObjectsPredicate] firstObject];
        
        BPVAccountant *accountant = [[[adminBuilding workersWithClass:[BPVAccountant class]] filteredArrayUsingPredicate:freeObjectsPredicate] firstObject];
        
        washer.busy = YES;
        director.busy = YES;
        accountant.busy = YES;
        
        BPVCarWashRoom *washRoom = [[[carWashBuilding roomsWithClass:[BPVCarWashRoom class]]
                                     filteredArrayUsingPredicate:
                                     [NSPredicate predicateWithBlock:^BOOL(BPVCarWashRoom *room, NSDictionary *bindings) {
                                        return !room.car;
                                    }]] firstObject];
        
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

@end
