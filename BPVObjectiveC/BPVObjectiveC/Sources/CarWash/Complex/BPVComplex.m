//
//  BPVComplex.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVComplex.h"

#import "BPVWorker.h"
#import "BPVDirector.h"
#import "BPVAccountant.h"
#import "BPVWasher.h"
#import "BPVCar.h"

#import "BPVQueue.h"

#import "BPVObservableObject.h"

#import "NSObject+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

static const NSUInteger kBPVWashersCount = 3;

@interface BPVComplex ()
@property (nonatomic, retain) BPVDirector       *director;
@property (nonatomic, retain) BPVAccountant     *accountant;
@property (nonatomic, retain) NSMutableArray    *washers;
@property (nonatomic, retain) BPVQueue          *carsQueue;
@property (nonatomic, retain) BPVQueue          *freeWashersQueue;

- (void)initInfrastructure;
- (void)initWorkers;
- (void)initQueues;

- (void)addWasher:(id)washer;
- (void)removeWorker:(id)washer;

- (id)reservedFreeWasher;

- (void)removeWorkersObservers;
- (NSArray *)allWorkers;

@end

@implementation BPVComplex

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    [self removeWorkersObservers];
    
    self.director = nil;
    self.accountant = nil;
    self.washers = nil;
    self.carsQueue = nil;
    self.freeWashersQueue = nil;
        
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    [self initInfrastructure];
    
    return self;
}

- (void)initInfrastructure {
    [self initWorkers];
    [self initQueues];
}

- (void)initWorkers {
    self.washers = [NSMutableArray array];
    BPVDirector *director = [BPVDirector object];
    self.director = director;
    BPVAccountant *accountant = [BPVAccountant object];
    self.accountant = accountant;
    
    [accountant addObserver:director];
    
    for (NSUInteger iterator = 0; iterator < kBPVWashersCount; iterator++) {
        BPVWasher *washer = [BPVWasher object];
        [self addWasher:washer];
        [washer addObservers:@[accountant, self]];
    }
}

- (void)initQueues {
    BPVQueue *freeWashersQueue = [BPVQueue object];
    self.freeWashersQueue = freeWashersQueue;
    [freeWashersQueue enqueueObjects:self.washers];
    self.carsQueue = [BPVQueue object];
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(BPVCar *)carToWash {
    BPVQueue *carsQueue = self.carsQueue;
    [carsQueue enqueueObject:carToWash];
    
    BPVWasher *washer = nil;
    BPVCar *car = nil;
    while ((car = [carsQueue dequeueObject])) {
        @synchronized (car) {
            washer = [self reservedFreeWasher];
            if (washer) {
                [washer performSelectorInBackground:@selector(processObject:) withObject:car];
            } else {
                [carsQueue enqueueObject:car];
            }
        }
    }
}

- (void)removeWorkersObservers {
    for (BPVWorker *worker in [self allWorkers]) {
        [worker removeObservers];
    }
}

- (NSArray *)allWorkers {
    NSMutableArray *workers = [NSMutableArray arrayWithObjects:
                               self.accountant,
                               self.director,
                               nil];
    
    [workers addObjectsFromArray:self.washers];
    
    return [[workers copy] autorelease];
}

- (id)reservedFreeWasher {
    BPVWasher *freeWasher = [self.freeWashersQueue dequeueObject];
    freeWasher.state = BPVWorkerStateBusy;
    
    return freeWasher;
}

#pragma mark -
#pragma mark Delegate methods

- (void)workerDidBecomeFree:(BPVWorker *)worker {
    [self.freeWashersQueue enqueueObject:worker];
}

#pragma mark -
#pragma mark Private Implementation

- (void)addWasher:(id)washer {
    @synchronized (self) {
        if (washer) {
            [self.washers addObject:washer];
        }
    }
}

- (void)removeWorker:(id)washer {
    [self.washers removeObject:washer];
}

@end
