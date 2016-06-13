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

#pragma marc
#pragma marc Deallocation

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

#pragma marc
#pragma marc Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableChildren = [NSMutableArray object];

    
    return self;
}

#pragma marc
#pragma marc Public Implementation

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

#pragma marc
#pragma marc Private Implementation

- (void)sayHi {
    NSLog(@"Creature %@ says HI!", self.name);
}

- (void)childrenSayHi {
    for (BPVCreature *child in self.children) {
        [child sayHi];
    }
}

@end
