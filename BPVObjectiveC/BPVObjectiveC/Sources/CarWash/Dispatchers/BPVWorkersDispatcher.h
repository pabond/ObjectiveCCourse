//
//  BPVWorkersDispatcher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVQueue.h"

@interface BPVWorkersDispatcher : NSObject
@property (nonatomic, readonly) NSArray     *processors;
@property (nonatomic, readonly) BPVQueue    *objectsToProcess;
@property (nonatomic, readonly) BPVQueue    *freeProcessors;

+ (instancetype)dispatcherWithProcessors:(NSArray *)processors

- (void)addProcessor:(id)processor;
- (void)removeProcessor:(id)processor;

- (void)addProcessors:(NSArray *)processors;
- (void)removeProcessors:(NSArray *)processors;

- (void)processObject:(id)object;

@end
