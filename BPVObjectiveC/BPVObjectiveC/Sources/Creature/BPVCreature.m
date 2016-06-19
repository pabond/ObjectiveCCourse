//
//  BPVCreature.m
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCreature.h"

#import "NSObject+BPVExtensions.h"

@interface BPVCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChildren;

- (void)sayHi;
- (void)childrenSayHi;

@end

@implementation BPVCreature

@dynamic children;

#pragma mark -
#pragma mark Deallocation / Initialisation

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableChildren = [NSMutableArray object];

    
    return self;
}

#pragma mark -
#pragma mark Public Implementation

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

- (void)addChild:(BPVCreature *)child {
    if (child) {
        [self.mutableChildren addObject:child];
    }
}

- (void)removeChild:(BPVCreature *)child {
    [self.mutableChildren removeObject:child];
}

- (void)allSayHi {
    [self sayHi];
    [self childrenSayHi];
}

- (void)performGenderSpecificOperation {
    NSLog(@"Sleep well!");
}

#pragma mark -
#pragma mark Private Implementation

- (void)sayHi {
    NSLog(@"Creature %@ says HI!", self.name);
}

- (void)childrenSayHi {
    for (BPVCreature *child in self.children) {
        [child sayHi];
    }
}

@end
