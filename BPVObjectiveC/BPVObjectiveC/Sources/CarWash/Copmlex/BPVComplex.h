//
//  BPVComplex.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVBuilding.h"
#import "BPVCar.h"

@interface BPVComplex : NSObject
@property (nonatomic, retain) BPVBuilding *adminBuilding;
@property (nonatomic, retain) BPVBuilding *carWashBuilding;
@property (nonatomic, readonly) NSArray *cars;

- (void)addCar:(BPVCar *)car;
- (void)removeCar:(id)car;

- (void)processCars;
- (void)washCar:(BPVCar *)car;

@end
