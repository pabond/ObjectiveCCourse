//
//  BPVWorker.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVMoneyFlow.h"

typedef enum {
    BPVWorkerPositionDirector,
    BPVWorkerPositionAccountant,
    BPVWorkerPositionWasher
} BPVWorkerPosition;

@interface BPVWorker : NSObject <BPVMoneyFlow>

@property (nonatomic, readonly) NSArray             *workers;
@property (nonatomic, assign)   BPVWorkerPosition   position;
@property (nonatomic, assign)   uint8_t             experience;
@property (nonatomic, assign)   NSUInteger          salary;
@property (nonatomic, copy)     NSString            *responsibility;

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;

@end
