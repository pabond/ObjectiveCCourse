//
//  BPVWorker.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVObservableObject.h"

#import "BPVWorkersDelegate.h"
#import "BPVMoneyFlow.h"

typedef NS_ENUM(uint8_t, BPVWorkerState) {
    BPVWorkerStateFree,
    BPVWorkerStateBusy,
    BPVWorkerStatePending
};

@protocol BPVWorkersObserver <NSObject>

@optional
- (void)workerDidFinishProcessing:(id)worker object:(id)object;
- (void)workerDidBecomeFree:(id)worker;
- (void)workerStartProcessing:(id)worker object:(id)object;


@end

@interface BPVWorker : BPVObservableObject <BPVMoneyFlow>
@property (nonatomic, assign)   NSUInteger  experience;
@property (nonatomic, assign)   NSUInteger  salary;
@property (nonatomic, assign)   BOOL        busy;

@property (nonatomic, assign)   id<BPVWorkersDelegate>  delegate;

- (void)processObject:(id)object;
- (void)performWorkWithObject:(id)object;

@end
