//
//  BPVGCD.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/18/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVGCD.h"

void BPVAsyncPerformBlockOnMainQueue(BPVBlock block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void BPVAsyncPerformBlockOnBackgroundQueue(BPVBlock block) {
    dispatch_async(dispatch_get_global_queue(BPVDispatchQueuePriorityTypeBackgroung, 0), block);
}