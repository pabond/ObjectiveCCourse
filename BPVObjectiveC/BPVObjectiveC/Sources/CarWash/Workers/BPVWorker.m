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

- (void)startProcessingObjectInBackground:(id)object;

@end

@implementation BPVWorker

#pragma mark -
#pragma mark Accessors


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
    @synchronized (self) {
        [self acceptMoney:[object giveMoney]];
    }
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"Selector:\"performWorkWithObject\" should be launched in child classes");
}

#pragma mark -
#pragma mark Public implementations

- (void)processObject:(id)object {
    @synchronized (self) {
        [self performSelectorInBackground:@selector(startProcessingObjectInBackground:) withObject:object];
    }
}

- (void)startProcessingObjectInBackground:(id)object {
    @synchronized (self) {
        NSLog(@"Worker %@ start processing object %@ in background", self, object);
        [self performWorkWithObject:object];
        [self performSelectorOnMainThread:@selector(finishProcessingOnMainThreadWithObject:)
                               withObject:object
                            waitUntilDone:NO];
    }
}

- (void)finishProcessingOnMainThreadWithObject:(id)object {
    @synchronized (self) {
        [self finishProcessingObject:object];
    }
    
    @synchronized (self) {
        [self finishProcessing];
    }
}

- (void)finishProcessingObject:(BPVWorker *)worker {    //change object state
    @synchronized (worker) {
        NSLog(@"Worker become free");
        worker.state = BPVWorkerStateFree;
    }
}

- (void)finishProcessing {                              //change self state
    @synchronized (self) {
        NSLog(@"Worker become pending");
        self.state = BPVWorkerStatePending;
    }
}

#pragma mark -
#pragma mark Delegate methods

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
            
        case BPVWorkerStatePending:
            return @selector(workerDidBecomeReadyForProcessing:);
            
        case BPVWorkerStateBusy:
            return @selector(workerDidBecomeBusy:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
