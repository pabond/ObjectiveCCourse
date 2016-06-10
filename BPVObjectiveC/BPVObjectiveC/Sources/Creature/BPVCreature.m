//
//  BPVCreature.m
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCreature.h"

@implementation BPVCreature

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (void)sayHi {
    NSLog(@"Creature %@ says HI!", self.name);
}

- (void)performGenderSpecificOperation {
    NSLog(@"Sleep well!");
}

@end
