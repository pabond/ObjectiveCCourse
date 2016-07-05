//
//  BPVWorker.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVObservableObject.h"

#import "BPVMoneyFlow.h"

typedef NS_ENUM(uint8_t, BPVWorkerState) {
    BPVWorkerStateFree,
    BPVWorkerStateBusy,
    BPVWorkerStatePending
};

@protocol BPVWorkersObserver <NSObject>

@optional
- (void)workerDidBecomeReadyForProcessing:(id)worker;
- (void)workerDidBecomeFree:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;

@end

@interface BPVWorker : BPVObservableObject <BPVMoneyFlow>
@property (nonatomic, assign)   NSUInteger  experience;
@property (nonatomic, assign)   NSUInteger  salary;

- (void)processObject:(id)object;
- (void)performWorkWithObject:(id)object;

- (void)finishProcessing;
- (void)finishProcessingObject:(id)object;

@end
