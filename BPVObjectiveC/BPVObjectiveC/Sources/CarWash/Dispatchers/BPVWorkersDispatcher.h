//
//  BPVWorkersDispatcher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVWorker.h"

@interface BPVWorkersDispatcher : NSObject <BPVWorkersObserver>
@property (nonatomic, readonly) NSArray     *processors;

- (void)addProcessor:(id)processor;
- (void)removeProcessor:(id)processor;

- (void)addProcessors:(NSArray *)processors;
- (void)removeProcessors:(NSArray *)processors;

- (void)addFreeProcessorsQueue;

- (void)processObject:(id)object;

@end
