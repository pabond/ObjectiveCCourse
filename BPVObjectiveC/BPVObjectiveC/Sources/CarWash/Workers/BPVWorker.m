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

@end

@implementation BPVWorker

#pragma mark -
#pragma mark Accessors


#pragma mark -
#pragma mark BPVMoneyFlow

- (void)acceptMoney:(NSUInteger)value {
    self.money += value;
}

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
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
    
    [self performWorkWithObject:object];
    [self performSelectorOnMainThread:@selector(finishProcessingObject:)
                           withObject:object
                        waitUntilDone:NO];                      //change object state
    
    [self performSelectorOnMainThread:@selector(finishProcessing)
                           withObject:nil
                        waitUntilDone:NO];                      //change self state
}

- (void)finishProcessingObject:(BPVWorker *)worker {
    worker.state = BPVWorkerStateFree;
}

- (void)finishProcessing {
    self.state = BPVWorkerStatePending;
}

#pragma mark -
#pragma mark Delegate methods

- (void)workerDidBecomeReadyForProcessing:(id)object {
    [self processObject:object];
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
