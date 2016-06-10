//
//  BPVCreatureFemale.m
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCreatureFemale.h"

#import "NSObject+BPVExtensions.h"

@interface BPVCreatureFemale ()

@property (nonatomic, retain) NSMutableArray *mutableChildren;

@end

@implementation BPVCreatureFemale

@dynamic children;

- (void)dealloc {
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableChildren = [NSMutableArray object];
    
    return self;
}

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

- (BPVCreature *)giveBirthToChild {
    BPVCreature *child = [BPVCreature object];
    [self.mutableChildren addObject:child];
    NSLog(@"Child was born!");
    
    return child;
}

- (BPVCreature *)giveBirthToChildWithName:(NSString *)name {
    BPVCreature *child = [BPVCreature object];
    [child setName:name];
    
    return child;
}

- (void)performGenderSpecificOperation {
    BPVCreature *child = [self giveBirthToChildWithName:@"baby"];
    [child sayHi];
}

@end
