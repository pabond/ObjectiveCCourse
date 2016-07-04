//
//  BPVObservableObject.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

#import "BPVAssingReference.h"

@interface BPVObservableObject ()
@property (nonatomic, retain) NSHashTable     *observersTable;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;
- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object;

@end

@implementation BPVObservableObject

@dynamic observersSet;

#pragma mark -
#pragma mark Initialisations / Deallocations

- (void)dealloc {
    self.observersTable = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observersTable = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (NSSet *)observersSet {
    return self.observersTable.setRepresentation;
}

#pragma mark -
#pragma mark - Public implementations

- (void)addObserver:(id)observer {
    if (observer) {
        [self.observersTable addObject:observer];
    }
}

- (void)addObservers:(NSArray *)observers {
    for (id observer in observers) {
        [self addObserver:observer];
    }
}

- (void)removeObserver:(NSObject *)observer {
    [self.observersTable removeObject:observer];
}

- (BOOL)containsObserver:(id)object {
    return [self.observersTable containsObject:object];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChangeWithSelector:[self selectorForState:state]];
    }
}

- (void)setState:(NSUInteger)state withObject:(id)object {
    [object setState:state];
}

- (void)notifyWithObject:(id)object ofState:(NSUInteger)state {
    [object selectorForState:state];
}

- (void)removeObservers {
    self.observersTable = nil;
}

#pragma mark - 
#pragma mark - Private implementations

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector object:nil];
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object {
    NSHashTable *observers = self.observersTable;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self withObject:object];
        }
    }
}

@end
