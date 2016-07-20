//
//  BPVGCD.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/18/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVGCD.h"

#pragma mark -
#pragma mark Privat declarations

void BPVPerformBlockOnMainQueueWithTypeAndBlock(BPVBlockExecutionType type, BPVBlock block);

void BPVPefromBlockWithQueueAndType(BPVBlockExecutionType type, dispatch_queue_t queue, BPVBlock block);

#pragma mark -
#pragma mark Public implementations

void BPVPerformAsyncBlockOnMainQueue(BPVBlock block) {
    BPVPerformBlockOnMainQueueWithTypeAndBlock(BPVBlockExecutionAsynchronous, block);
}

void BPVPerformSyncBlockOnMainQueue(BPVBlock block) {
    BPVPerformBlockOnMainQueueWithTypeAndBlock(BPVBlockExecutionSynchronous, block);
}

void BPVPerformAsyncBlockOnBackgroundQueue(BPVBlock block) {
    BPVPefromBlockWithQueueAndType(BPVBlockExecutionAsynchronous,
                                   BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityBackground),
                                   block);
}

void BPVPerformSyncBlockOnBackgroundQueue(BPVBlock block) {
    BPVPefromBlockWithQueueAndType(BPVBlockExecutionSynchronous,
                                   BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityBackground),
                                   block);
}

void BPVPerformAsyncBlockOnLowQueue(BPVBlock block) {
    BPVPefromBlockWithQueueAndType(BPVBlockExecutionAsynchronous,
                                   BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityLow),
                                   block);
}

void BPVPerformSyncBlockOnLowQueue(BPVBlock block) {
    BPVPefromBlockWithQueueAndType(BPVBlockExecutionSynchronous,
                                   BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityLow),
                                   block);
}

dispatch_queue_t BPVDisptchQueueWithPriorityType(BPVDispatchQueuePriorityType type) {
    return dispatch_get_global_queue(type, 0);
}

#pragma mark -
#pragma mark Privat implementations

void BPVPerformBlockOnMainQueueWithTypeAndBlock(BPVBlockExecutionType type, BPVBlock block) {
     BPVPefromBlockWithQueueAndType(type, dispatch_get_main_queue(), block);
}

void BPVPefromBlockWithQueueAndType(BPVBlockExecutionType type, dispatch_queue_t queue, BPVBlock block) {
    if (!block) {
        return;
    }
    
    switch (type) {
        case BPVBlockExecutionSynchronous:
            dispatch_sync(queue, block);
            break;
            
        case BPVBlockExecutionAsynchronous:
            dispatch_async(queue, block);
            break;
            
        default:
            break;
    }
}
