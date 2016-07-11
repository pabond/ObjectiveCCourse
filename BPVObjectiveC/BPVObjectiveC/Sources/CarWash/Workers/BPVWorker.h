//
//  BPVWorker.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVObservableObject.h"
#import "BPVQueue.h"

#import "BPVMoneyFlow.h"

typedef NS_ENUM(uint8_t, BPVWorkerState) {
    BPVWorkerStateFree,
    BPVWorkerStateBusy,
    BPVWorkerStatePending
};

@interface BPVWorker : BPVObservableObject <BPVMoneyFlow>
@property (nonatomic, assign)   NSUInteger  experience;
@property (nonatomic, assign)   NSUInteger  salary;
@property (nonatomic, readonly) BPVQueue    *queue;

- (void)processObject:(id)object;
- (void)performWorkWithObject:(id)object;

- (void)finishProcessing;
- (void)finishProcessingObject:(id)object;

@end

@protocol BPVWorkersObserver <NSObject>

@optional
- (void)workerDidBecomeReadyForProcessing:(id)worker;
- (void)workerDidBecomeFree:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;

@end
