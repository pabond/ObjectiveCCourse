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

#import "NSObject+BPVExtensions.h"

@interface BPVComplex ()
@property (nonatomic, retain) NSMutableArray *mutableCars;

- (id)freeObject:(id)arrey withClass:(Class)cls;

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
    self.adminBuilding = [BPVBuilding object];
    self.carWashBuilding = [BPVBuilding object];
    self.mutableCars = [NSMutableArray object];
    
    return self;
}

#pragma marc
#pragma marc Public Implementation

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

- (void)addCar:(id)car {
    if (car) {
        [self.mutableCars addObject:car];
    }
}

- (void)removeCar:(id)car {
    if (car) {
        [self.mutableCars removeObject:car];
    }
}


- (void)washCar:(BPVCar *)car {
    if (car.isClean) {
        return;
    }
    
    BPVCarWashRoom *washRoom = [self freeObject:[self.carWashBuilding rooms] withClass: [BPVCarWashRoom class]];
    BPVWasher *washer = [self freeObject:washRoom.workers withClass:[BPVWasher class]];
    washRoom.car = car;
    [washer washCar:car];
    [washer takeMoney:car];
    washRoom.car = nil;
}

- (void)moneyflow:(id)object {
    BPVAdminRoom *adminRoom = [self freeObject:[self.adminBuilding rooms] withClass:[BPVAdminRoom class]];
    BPVAccountant *accountant = [self freeObject:adminRoom.workers withClass:[BPVAccountant class]];
    BPVDirector *director = [self freeObject:adminRoom.workers withClass:[BPVDirector class]];
    
    [accountant takeMoney:object];
    [accountant countMoney];
    
    [director takeMoney:accountant];
    [director earnMoney];
}

#pragma marc
#pragma marc Private Implementation

- (id)freeObject:(id)arrey withClass:(Class)cls {
    for (id<BPVIsBusyObject> object in arrey) {
        if (!object.isBusy && [object isKindOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}

@end
