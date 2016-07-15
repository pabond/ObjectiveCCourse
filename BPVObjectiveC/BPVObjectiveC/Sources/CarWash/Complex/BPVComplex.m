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

typedef NSArray *(^BPVWorkersFactory)(Class class, NSUInteger count, id observers, NSString *name);

static const NSUInteger kBPVWashersCount        = 5;
static const NSUInteger kBPVAccountantsCount    = 3;
static const NSUInteger kBPVDirectorsCount      = 1;

static NSString   *kBPVWasherName       = @"Washer";
static NSString   *kBPVAccountantName   = @"Accountant";
static NSString   *kBPVDirectorName     = @"Director";

@interface BPVComplex ()
@property (nonatomic, retain) BPVWorkersDispatcher *washersDispatcher;
@property (nonatomic, retain) BPVWorkersDispatcher *accountansDispatcher;
@property (nonatomic, retain) BPVWorkersDispatcher *directorsDispatcher;

- (void)initInfrastructure;
- (void)initDipatchers;
- (void)initProcessors;

- (void)removeProcessorsObservers;

@end

@implementation BPVComplex

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    [self removeProcessorsObservers];
    
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
    [self initDipatchers];
    [self initProcessors];
}

- (void)initDipatchers {
    self.directorsDispatcher = [BPVWorkersDispatcher object];
    self.accountansDispatcher = [BPVWorkersDispatcher object];
    self.washersDispatcher = [BPVWorkersDispatcher object];
}

- (void)initProcessors {
    __block NSUInteger iterator = 1;
    BPVWorkersFactory workersFactory = ^NSArray *(Class class, NSUInteger count, id observers, NSString *name) {
        return [NSArray arrayWithObjectsCount:count block:^ {
            BPVWorker *worker = [class object];
            [worker addObservers:observers];
            worker.name = [NSString stringWithFormat:@"%@%lu", name, (unsigned long)iterator++];
            
            return worker;
        }];
    };
    
    BPVWorkersDispatcher *directorsDispatcher = self.directorsDispatcher;
    [directorsDispatcher addProcessors:workersFactory([BPVDirector class],
                                                      kBPVDirectorsCount,
                                                      @[directorsDispatcher],
                                                      kBPVDirectorName)];
    
    [directorsDispatcher addFreeProcessorsQueue];
    
    iterator = 1;
    BPVWorkersDispatcher *accountansDispatcher = self.accountansDispatcher;
    [accountansDispatcher addProcessors:workersFactory([BPVAccountant class],
                                                       kBPVAccountantsCount,
                                                       @[accountansDispatcher, directorsDispatcher],
                                                       kBPVAccountantName)];
    
    [accountansDispatcher addFreeProcessorsQueue];
    
    iterator = 1;
    BPVWorkersDispatcher *washersDispatcher = self.washersDispatcher;
    [washersDispatcher addProcessors:workersFactory([BPVWasher class],
                                                    kBPVWashersCount,
                                                    @[accountansDispatcher, washersDispatcher],
                                                    kBPVWasherName)];

    [washersDispatcher addFreeProcessorsQueue];
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


- (void)removeProcessorsObservers {
    void (^BPVRemoveObservers)(id collection, id observers) = ^(id collection, id observers) {
        for (BPVWorker *processor in collection) {
            [processor removeObservers:observers];
        }
    };
    
    BPVWorkersDispatcher *directorsDispatcher = self.directorsDispatcher;
    BPVWorkersDispatcher *accountansDispatcher = self.accountansDispatcher;
    BPVWorkersDispatcher *washersDispatcher = self.washersDispatcher;
    
    BPVRemoveObservers(directorsDispatcher.processors, @[directorsDispatcher]);
    BPVRemoveObservers(accountansDispatcher.processors, @[accountansDispatcher, directorsDispatcher]);
    BPVRemoveObservers(washersDispatcher.processors, @[washersDispatcher, accountansDispatcher]);
}

@end
