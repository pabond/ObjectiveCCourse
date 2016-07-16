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

typedef NSArray *(^BPVWorkersFactory)(Class class, NSUInteger count, id observer, NSString *name);

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
- (void)initDipatchersWithProcessors;

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
    [self initDipatchersWithProcessors];
}

- (void)initDipatchersWithProcessors {
    BPVWorkersFactory workersFactory = ^NSArray *(Class class, NSUInteger count, id observer, NSString *name) {
        __block NSUInteger iterator = 0;
        return [NSArray arrayWithObjectsCount:count block:^ {
            BPVWorker *worker = [class processorWithName:[NSString stringWithFormat:@"%@%lu",
                                                          name,
                                                          (unsigned long)++iterator]];
            
            [worker addObserver:observer];
            
            return worker;
                }];
    };
    
    self.directorsDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workersFactory([BPVDirector class],
                                                                                             kBPVDirectorsCount,
                                                                                             nil,
                                                                                             kBPVDirectorName)];
    
    self.accountansDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workersFactory([BPVAccountant class],
                                                                                              kBPVAccountantsCount,
                                                                                              self.directorsDispatcher,
                                                                                              kBPVAccountantName)];
    
    self.washersDispatcher = [BPVWorkersDispatcher dispatcherWithProcessors:workersFactory([BPVWasher class],
                                                                                           kBPVWashersCount,
                                                                                           self.accountansDispatcher,
                                                                                           kBPVWasherName)];
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
    void (^BPVRemoveObservers)(id collection, id observer) = ^(id collection, id observer) {
        for (BPVWorker *processor in collection) {
            [processor removeObserver:observer];
        }
    };
    
    BPVWorkersDispatcher *accountansDispatcher = self.accountansDispatcher;
    
    BPVRemoveObservers(accountansDispatcher.processors, @[self.directorsDispatcher]);
    BPVRemoveObservers(self.washersDispatcher.processors, @[accountansDispatcher]);
}

@end
