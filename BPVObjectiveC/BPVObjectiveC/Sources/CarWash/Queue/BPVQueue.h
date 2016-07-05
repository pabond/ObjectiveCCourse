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
@property (nonatomic, readonly) NSUInteger objectsCount;

- (void)enqueueObject:(id)object;
- (id)dequeueObject;

- (void)enqueueObjects:(NSArray *)objects;
- (void)dequeueAllObjects;

@end
