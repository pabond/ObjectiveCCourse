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

- (id)freeObject:(id)arrey withClass:(Class)cls;

@end

@implementation BPVComplex

- (instancetype)init {
    self = [super init];
    self.adminBuilding = [BPVBuilding object];
    self.carWashBuilding = [BPVBuilding object];
    
    return self;
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

- (void)moneyflow:(BPVWasher *)washer {
    BPVAdminRoom *adminRoom = [self freeObject:[self.adminBuilding rooms] withClass:[BPVAdminRoom class]];
    BPVAccountant *accountant = [self freeObject:adminRoom.workers withClass:[BPVAccountant class]];
    BPVDirector *director = [self freeObject:adminRoom.workers withClass:[BPVDirector class]];
    
    [accountant takeMoney:washer];
    [accountant countMoney];
    
    [director takeMoney:accountant];
    [director earnMoney];
}

- (id)freeObject:(id)arrey withClass:(Class)cls {
    for (id<BPVIsBusyObject> object in arrey) {
        if (!object.isBusy && [object isKindOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}

@end
