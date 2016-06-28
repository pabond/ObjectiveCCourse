//
//  BPVObservableObject.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVObservableObject ()
@property (nonatomic, retain) NSMutableSet    *mutableObserverSet;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;
- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object;

@end

@implementation BPVObservableObject

@dynamic observerSet;

#pragma mark -
#pragma mark Initialisations / Deallocations

- (void)dealloc {
    self.mutableObserverSet = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObserverSet = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (NSSet *)observerSet {
    return [[[self mutableObserverSet] copy] autorelease];
}

#pragma mark -
#pragma mark - Public implementations

- (void)addObserver:(id)observer {
    [self.mutableObserverSet addObject:observer];
}

- (void)removeObserver:(NSObject *)observer {
    [self.mutableObserverSet removeObject:observer];
}

- (BOOL)containsObserver:(id)object {
    return [self.mutableObserverSet containsObject:object];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChangeWithSelector:[self selectorForState:state]];
    }
}

#pragma mark - 
#pragma mark - Private implementations

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector object:self];
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object {
    NSMutableSet *observerSet = self.mutableObserverSet;
    for (id observer in observerSet) {
        if ([observerSet respondsToSelector:selector]) {
            [observer performSelector:selector withObject:object];
        }
    }
}

@end
