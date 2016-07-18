//
//  BPVGCD.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/18/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BPVDispatchQueuePriorityTypeHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    BPVDispatchQueuePriorityTypeDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    BPVDispatchQueuePriorityTypeLow = DISPATCH_QUEUE_PRIORITY_LOW,
    BPVDispatchQueuePriorityTypeBackgroung = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
} BPVDispatchQueuePriorityType;
