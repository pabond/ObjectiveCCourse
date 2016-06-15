//
//  BPVComplex.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplex.h"

#import "BPVCarWashRoom.h"
#import "BPVWasher.h"
#import "BPVAccountant.h"
#import "BPVDirector.h"
#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"

@interface BPVComplex ()
@property (nonatomic, retain) NSMutableArray *mutableCars;

@end

@implementation BPVComplex

@dynamic cars;

#pragma marc
#pragma marc Initialisation/Deallocation

- (void)dealloc {
    self.adminBuilding = nil;
    self.carWashBuilding = nil;
    self.mutableCars = nil;
        
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    self.adminBuilding = [BPVBuilding object];
    self.carWashBuilding = [BPVBuilding object];
    self.mutableCars = [NSMutableArray object];
}

#pragma marc
#pragma marc Public Implementation

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

- (void)addCar:(BPVCar *)car {
    if (car && !car.isClean) {
        [self.mutableCars addObject:car];
    }
}

- (void)removeCar:(id)car {
    [self.mutableCars removeObject:car];
}

- (void)processCars {
    while (self.cars.count) {
        [self washCar:self.cars[0]];
    }
}

- (void)washCar:(BPVCar *)car {
    if (car.isClean) {
        return;
    }
    
    BPVAdminRoom *adminRoom = [self.adminBuilding freeRoomWithClass:[BPVAdminRoom class]];
    BPVCarWashRoom *washRoom = [self.carWashBuilding freeRoomWithClass:[BPVCarWashRoom class]];
    BPVWasher *washer = [washRoom freeWorkerWithClass:[BPVWasher class]];
    
    washRoom.car = car;
    [washer washCar:car];
    
    if (car.isClean) {
        [washer takeMoneyFromObject:car];
        
        BPVDirector *director = [adminRoom freeWorkerWithClass:[BPVDirector class]];
        BPVAccountant *accountant = [adminRoom freeWorkerWithClass:[BPVAccountant class]];
        
        [accountant takeMoneyFromObject:car];
        [accountant countMoney];
        
        [director takeMoneyFromObject:accountant];
        [director earnMoney];
        
        [self removeCar:car];
    }
    
    washRoom.car = nil;
}

@end
