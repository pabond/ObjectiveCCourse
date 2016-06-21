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
@property (nonatomic, retain) NSMutableArray *carsQueue;

@end

@implementation BPVQueue

@dynamic queue;

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.carsQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.carsQueue = [NSMutableArray object];
    
    return self;
}

- (NSArray *)queue {
    return [[self.carsQueue copy] autorelease];
}

- (void)inQueueObject:(id)object {
    if (object) {
        [self.carsQueue addObject:object];
    }
}

- (id)deQueueNext {
    NSMutableArray *queue = self.carsQueue;
    if (!queue.count) {
        return nil;
    }
    
    id nextObject = queue[0];
    [[nextObject retain] autorelease];
    [queue removeObject:nextObject];
    
    return nextObject;
}

@end

