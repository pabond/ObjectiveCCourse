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
    BPVWorkerStateReadyForProcessing
};

@protocol BPVWorkersObserver <NSObject>

@optional
- (void)workerDidBecomeReadyForProcessing:(id)worker;
- (void)workerDidBecomeFree:(id)worker;
- (void)workerDidBecomeBusy:(id)worker;

@end

@interface BPVWorker : BPVObservableObject <BPVMoneyFlow, BPVWorkersObserver>
@property (nonatomic, assign)   NSUInteger  experience;
@property (nonatomic, assign)   NSUInteger  salary;
@property (nonatomic, readonly) BPVQueue    *queue;
@property (nonatomic, copy)     NSString    *name;

- (void)processObject:(id)object;
- (void)performWorkWithObject:(id)object;

// do not lounch these methods directly. Moved to heder for reordering or launching in chlid classes
- (void)finishProcessing;
- (void)finishProcessingObject:(id)object;
- (void)startProcessingObject:(id)object;

@end