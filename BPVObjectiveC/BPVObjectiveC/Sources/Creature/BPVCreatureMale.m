//
//  BPVCreatureMale.m
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCreatureMale.h"

@implementation BPVCreatureMale

- (void)fight {
    NSLog(@"%@ go to fight.", self.name);
}

- (void)performGenderSpecificOperation {
    [self fight];
}

@end
