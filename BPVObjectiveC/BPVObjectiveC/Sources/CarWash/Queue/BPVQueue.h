//
//  BPVQueue.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVQueue : NSObject
@property (nonatomic, readonly) NSArray *queue;

- (void)inQueueObject:(id)object;
- (id)deQueueNext;

@end
