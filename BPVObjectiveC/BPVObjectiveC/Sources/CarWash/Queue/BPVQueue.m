//
//  BPVQueue.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVQueue.h"

#import "NSObject+BPVExtensions.h"

@interface BPVQueue ()
@property (nonatomic, retain) NSMutableArray *mutableQueue;

@end

@implementation BPVQueue

@dynamic queue;

- (instancetype)init {
    self = [super init];
    self.mutableQueue = [NSMutableArray object];
    
    return self;
}

- (NSArray *)queue {
    return [[self.mutableQueue copy] autorelease];
}

- (void)inQueueObject:(id)object {
    [self.mutableQueue addObject:object];
}

- (id)deQueueNext {
    if (self.queue.count) {
        id nextObject = self.mutableQueue[0];
        [[nextObject retain] autorelease];
        [self.mutableQueue removeObjectAtIndex:0];
        
        return nextObject;
    }
    
    return nil;
}

@end

