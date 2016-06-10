//
//  BPVCar.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVMoneyFlow.h"

@interface BPVCar : NSObject <BPVMoneyFlow>

@property (nonatomic, assign, getter=isClean) BOOL clean;

@property (nonatomic, readonly) NSArray *cars;

- (void)addCar:(id)car;
- (void)removeCar:(id)car;

@end
