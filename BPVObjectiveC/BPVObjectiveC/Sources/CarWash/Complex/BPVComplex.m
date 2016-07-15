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

- (void)removeWorkersObservers;

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
    
    __block NSUInteger iterator = 0;
    NSArray *washerObservers = @[accountant, self];
    self.washers = [NSMutableArray arrayWithObjectsCount:kBPVWashersCount block:^{
        BPVWasher *washer = [BPVWasher object];
        [washer addObservers:washerObservers];
        washer.name = [NSString stringWithFormat:@"%@%lu", kBPVWasherName, (unsigned long)iterator++];
        
        return washer;
    }];
}

- (void)initQueues {
    BPVQueue *freeWashersQueue = [BPVQueue object];
    self.freeWashersQueue = freeWashersQueue;
    [freeWashersQueue enqueueObjects:self.washers];
    self.carsQueue = [BPVQueue object];
}

#pragma mark -
#pragma mark Public Implementation

- (void)washCar:(BPVCar *)car {
    if (car) {
        BPVWasher *washer = [self.freeWashersQueue dequeueObject];
        if (washer) {
            [washer processObject:car];
        } else {
            [self.carsQueue enqueueObject:car];
        }
    }
}

#pragma mark -
#pragma mark Private Implementation

- (void)removeWorkersObservers {
    BPVAccountant *accountant = self.accountant;
    [accountant removeObserver:self.director];
   
    NSArray *washerObservers = @[accountant, self];
    for (BPVWorker *worker in self.washers) {
        [worker removeObservers:washerObservers];
    }
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

#pragma mark -
#pragma mark BPVWorkersObserver

- (void)workerDidBecomeFree:(BPVWorker *)worker {
    BPVCar *car = [self.carsQueue dequeueObject];
    if (car) {
        [worker processObject:car];
    } else {
        [self.freeWashersQueue enqueueObject:worker];
    }
}

@end
