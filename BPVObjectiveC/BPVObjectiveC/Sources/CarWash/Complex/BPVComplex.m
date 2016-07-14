//
//  BPVComplex.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplex.h"

#import "BPVWorkersDispatcher.h"

#import "BPVWorker.h"
#import "BPVWasher.h"
#import "BPVDirector.h"
#import "BPVAccountant.h"

#import "BPVObservableObject.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

typedef NSArray *(^BPVNewWorkers)(Class class, NSUInteger count, id observer);

static const NSUInteger kBPVWashersCount = 5;
static const NSUInteger kBPVAccountantsCount = 3;
static const NSUInteger kBPVDirectorsCount = 1;
static const NSString *kBPVWasherName = @"Washer";

@interface BPVComplex ()
@property (nonatomic, retain) BPVWorkersDispatcher *washersDispatcher;
@property (nonatomic, retain) BPVWorkersDispatcher *accountansDispatcher;
@property (nonatomic, retain) BPVWorkersDispatcher *directorsDispatcher;

- (void)initInfrastructure;
- (void)initDipatchersWithProcessors;

- (void)addWasher:(id)washer;
- (void)removeWasher:(id)washer;

- (void)removeWorkersObservers;

@end

@implementation BPVComplex

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    [self removeWorkersObservers];
    self.washersDispatcher = nil;
    self.accountansDispatcher = nil;
    self.directorsDispatcher = nil;
        
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    [self initDipatchersWithProcessors];
}

- (void)initDipatchersWithProcessors {
    BPVNewWorkers workers = ^NSArray *(Class class, NSUInteger count, id observer) {
        return [[NSArray arrayWithObjectsCount:count usingBlock:^id {
            BPVWorker *worker = [class object];
            [worker addObservers:@[self, observer]];
             
             return worker;
              }] autorelease];
    };
    
    self.washersDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workers([BPVWasher class],
                                                                                    kBPVWashersCount,
                                                                                    self.accountansDispatcher)];
    
    self.accountansDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workers([BPVAccountant class],
                                                                                       kBPVAccountantsCount,
                                                                                       self.directorsDispatcher)];
    
    self.directorsDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workers([BPVDirector class],
                                                                                      kBPVDirectorsCount,
                                                                                      nil)];
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(id)car {
    if (car) {
        [self.washersDispatcher processObject:car];
    }
}

#pragma mark -
#pragma mark Private Implementation

/*
- (void)removeWorkersObservers {
    BPVAccountant *accountant = self.accountant;
    [accountant removeObserver:self.director];
   
    NSArray *washerObservers = @[accountant, self];
    for (BPVWorker *worker in self.washers) {
        [worker removeObservers:washerObservers];
    }
}

- (void)workerDidBecomeFree:(BPVWorker *)worker {
    BPVCar *car = [self.carsQueue dequeueObject];
    if (car) {
        [worker processObject:car];
    } else {
        [self.freeWashersQueue enqueueObject:worker];
    }
}

*/

@end
