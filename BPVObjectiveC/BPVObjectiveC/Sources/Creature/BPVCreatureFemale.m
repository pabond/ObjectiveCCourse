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
- (BPVCreature *)giveBirthToChild;

@end

@implementation BPVCreatureFemale

#pragma marc
#pragma marc Public Implementation

- (BPVCreature *)giveBirthToChildWithName:(NSString *)name {
    BPVCreature *child = [self giveBirthToChild];
    child.name = name;
    
    return child;
}

- (void)performGenderSpecificOperation {
    [self giveBirthToChildWithName:@"baby"];
}

#pragma marc
#pragma marc Private Implementation

- (BPVCreature *)giveBirthToChild {
    BPVCreature *child = [BPVCreature object];
    [self addChild:child];
    NSLog(@"Child was born!");
    
    return child;
}

@end
