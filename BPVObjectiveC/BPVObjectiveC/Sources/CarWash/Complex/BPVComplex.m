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
static const NSString *kBPVWasherName = @"Washer";

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
- (void)removeWasher:(id)washer;

- (id)reservedFreeWasher;

- (void)removeWorkersObservers;

- (void)processCar:(BPVCar *)car byWasher:(BPVWasher *)washer;
- (BPVCar *)nextCar;

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
    
    NSArray *washerObservers = @[accountant, self];
    for (NSUInteger iterator = 0; iterator < kBPVWashersCount; iterator++) {
        BPVWasher *washer = [BPVWasher object];
        [self addWasher:washer];
        washer.name = [NSString stringWithFormat:@"%@%lu", kBPVWasherName, (unsigned long)iterator];
        [washer addObservers:washerObservers];
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
    [self.carsQueue enqueueObject:carToWash];
    while ([self washNextCar]) {
        [self processCar:[self nextCar] byWasher:[self reservedFreeWasher]];
    }
}

#pragma mark -
#pragma mark BPVWorkersObserver

- (void)workerDidBecomeFree:(BPVWorker *)worker {
    BPVQueue *washersQueue = self.freeWashersQueue;
    @synchronized (washersQueue) {
        [washersQueue enqueueObject:worker];
        [self washCar:nil];
    }
}

#pragma mark -
#pragma mark Private Implementation

- (BOOL)washNextCar {
    @synchronized (self) {
        return [self.carsQueue objectsCount] && [self.freeWashersQueue objectsCount];
    }
}

- (void)processCar:(BPVCar *)car byWasher:(BPVWasher *)washer {
    @synchronized (self) {
        [washer performSelectorInBackground:@selector(startProcessingObject:) withObject:car];
    }
}

- (BPVCar *)nextCar {
    return [self.carsQueue dequeueObject];
}

- (void)removeWorkersObservers {
    BPVAccountant *accountant = self.accountant;
    [accountant removeObserver:self.director];
   
    NSArray *washerObservers = @[accountant, self];
    for (BPVWorker *worker in self.washers) {
        [worker removeObservers:washerObservers];
    }
}

- (id)reservedFreeWasher {
    BPVWasher *freeWasher = [self.freeWashersQueue dequeueObject];
    freeWasher.state = BPVWorkerStateBusy;
    
    return freeWasher;
}

- (void)addWasher:(id)washer {
    @synchronized (self) {
        if (washer) {
            [self.washers addObject:washer];
        }
    }
}

- (void)removeWasher:(id)washer {
    @synchronized (self) {
        [self.washers removeObject:washer];
    }
}

@end
