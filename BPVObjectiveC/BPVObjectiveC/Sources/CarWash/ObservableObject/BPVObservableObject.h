//
//  BPVObservableObject.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *observerSet;

- (void)addObserver:(id)observer;
- (void)removeObserver:(NSObject *)observer;
- (BOOL)containsObserver:(id)object;

- (SEL)selectorForState:(NSUInteger)state;

@end
