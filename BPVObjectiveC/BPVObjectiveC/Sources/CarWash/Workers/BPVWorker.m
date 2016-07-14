//
//  BPVWorker.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorker ()
@property (nonatomic, assign) NSUInteger    money;
@property (nonatomic, retain) BPVQueue      *queue;

- (void)finishProcessingOnMainThreadWithObject:(id)object;

@end

@implementation BPVWorker

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.queue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.queue = [BPVQueue object];
    
    return self;
}

#pragma mark -
#pragma mark BPVMoneyFlow

- (void)acceptMoney:(NSUInteger)value {
    @synchronized (self) {
        self.money += value;
    }
}

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger money = self.money;
        self.money = 0;
        
        return money;
    }
}

- (void)takeMoneyFromObject:(id<BPVMoneyFlow>)object {
    [self acceptMoney:[object giveMoney]];
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"Selector:\"performWorkWithObject\" should be launched in child classes");
}

#pragma mark -
#pragma mark Public implementations

- (void)processObject:(id)object {
    @synchronized (self) {
        if (self.state == BPVWorkerStateFree) {
            self.state = BPVWorkerStateBusy;
            [self performSelectorInBackground:@selector(startProcessingObject:) withObject:object];
        } else {
            [self.queue enqueueObject:object];
        }
    }
}

- (void)startProcessingObject:(id)object {
    NSLog(@"Worker %@ start processing object %@ in background", self, object);
    [self performWorkWithObject:object];
    [self performSelectorOnMainThread:@selector(finishProcessingOnMainThreadWithObject:)
                           withObject:object
                        waitUntilDone:NO];
}

- (void)finishProcessingOnMainThreadWithObject:(id)object {
    @synchronized (object) {
        [self finishProcessingObject:object];
    }
    
    BPVQueue *queue = self.queue;
    if (queue.objectsCount) {
        [self performSelectorInBackground:@selector(startProcessingObject:) withObject:[queue dequeueObject]];
    } else {
        @synchronized (self) {
            [self finishProcessing];
        }
    }
}

- (void)finishProcessingObject:(BPVWorker *)worker {    //change object state
    NSLog(@"Worker become free");
    worker.state = BPVWorkerStateFree;
}

- (void)finishProcessing {
    NSLog(@"Worker become ReadyForProcessing");
    self.state = BPVWorkerStateReadyForProcessing;
}

#pragma mark -
#pragma mark BPVWorkersObserver

- (void)workerDidBecomeReadyForProcessing:(id)object {
    @synchronized (self) {
        [self processObject:object];
    }
}

#pragma mark -
#pragma mark Owerloaded parent method

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVWorkerStateFree:
            return @selector(workerDidBecomeFree:);
            
        case BPVWorkerStateReadyForProcessing:
            return @selector(workerDidBecomeReadyForProcessing:);
            
        case BPVWorkerStateBusy:
            return @selector(workerDidBecomeBusy:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
