//
//  BPVGCD.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/18/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPVBlock)();

typedef enum {
    BPVDispatchQueuePriorityHigh        = DISPATCH_QUEUE_PRIORITY_HIGH,
    BPVDispatchQueuePriorityDefault     = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    BPVDispatchQueuePriorityLow         = DISPATCH_QUEUE_PRIORITY_LOW,
    BPVDispatchQueuePriorityBackground  = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
} BPVDispatchQueuePriorityType;

typedef enum {
    BPVBlockExecutionSynchronous,
    BPVBlockExecutionAsynchronous
} BPVBlockExecutionType;


void BPVPerformAsyncBlockOnMainQueue(BPVBlock block);
void BPVPerformSyncBlockOnMainQueue(BPVBlock block);

void BPVPerformAsyncBlockOnBackgroundQueue(BPVBlock block);
void BPVPerformSyncBlockOnBackgroundQueue(BPVBlock block);

void BPVPerformAsyncBlockOnLowQueue(BPVBlock block);
void BPVPerformSyncBlockOnLowQueue(BPVBlock block);

dispatch_queue_t BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityType type);
