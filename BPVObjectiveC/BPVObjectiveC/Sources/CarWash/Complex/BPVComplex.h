//
//  BPVComplex.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVBuilding.h"

@class BPVCar;

@interface BPVComplex : NSObject

- (void)washCars;
- (void)addCar:(BPVCar *)car;

@end
