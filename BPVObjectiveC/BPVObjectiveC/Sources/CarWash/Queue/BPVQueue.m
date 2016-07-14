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
@dynamic objectsCount;

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.mutableQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableQueue = [NSMutableArray object];
    
    return self;
}

- (NSArray *)queue {
    @synchronized (self.mutableQueue) {
        return [[self.mutableQueue copy] autorelease];
    }
}

- (NSUInteger)objectsCount {
    @synchronized (self.mutableQueue) {
        return self.queue.count;
    }
}

- (void)enqueueObject:(id)object {
    @synchronized (self) {
        if (object) {
            [self.mutableQueue addObject:object];
        }
    }
}

- (id)dequeueObject {
    @synchronized (self) {
        NSMutableArray *queue = self.mutableQueue;
        if (!queue.count) {
            return nil;
        }
        
        id nextObject = [[[queue firstObject] retain] autorelease];
        [queue removeObject:nextObject];
        
        return nextObject;
    }
}

- (void)enqueueObjects:(NSArray *)objects {
    @synchronized (self) {
        [self.mutableQueue addObjectsFromArray:objects];
    }
}

@end

