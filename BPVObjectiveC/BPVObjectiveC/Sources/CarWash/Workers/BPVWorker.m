//
//  BPVWorker.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

#import "BPVGCD.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorker ()
@property (nonatomic, assign) NSUInteger    money;
@property (nonatomic, copy)   NSString      *name;

- (instancetype)initProcessorWithName:name;

- (void)finishProcessingOnMainThreadWithObject:(id)object;

@end

@implementation BPVWorker

#pragma mark -
#pragma mark Class methods

+ (instancetype)processorWithName:(NSString *)name {
    return [[[self alloc] initProcessorWithName:name] autorelease];
}

#pragma mark -
#pragma mark Initalistations / Deallocations

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)initProcessorWithName:name {
    self = [super init];
    
    self.name = name;
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)processObject:(id)object {
    self.state = BPVWorkerStateBusy;
    dispatch_async(dispatch_get_global_queue(BPVDispatchQueuePriorityTypeBackgroung, 0), ^{
        [self performWorkWithObject:object];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self finishProcessingObject:object];
            [self finishProcessing];
        });
    });
}

//- (void)startProcessingObject:(id)object {
//    NSLog(@"%@ start processing object in background", self.name);
//    [self performWorkWithObject:object];
//    [self performSelectorOnMainThread:@selector(finishProcessingOnMainThreadWithObject:)
//                           withObject:object
//                        waitUntilDone:NO];
//}
//
//- (void)finishProcessingOnMainThreadWithObject:(id)object {
//    @synchronized (object) {
//        [self finishProcessingObject:object];
//    }
//    
//    [self finishProcessing];
//}

- (void)finishProcessingObject:(BPVWorker *)worker {    //change object state
    NSLog(@"%@ become free", worker.name);
    worker.state = BPVWorkerStateFree;
}

- (void)finishProcessing {
    NSLog(@"%@ become ReadyForProcessing", self.name);
    self.state = BPVWorkerStateReadyForProcessing;
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
