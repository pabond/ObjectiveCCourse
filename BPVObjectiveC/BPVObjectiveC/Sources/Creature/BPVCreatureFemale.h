//
//  BPVCreatureFemale.h
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCreature.h"

@interface BPVCreatureFemale : BPVCreature

@property (nonatomic, readonly) NSArray *children;

- (BPVCreature *)giveBirthToChildWithName:(NSString *)name;
- (BPVCreature *)giveBirthToChild;

- (void)addChild:(BPVCreature *)child;
- (void)removeChild:(BPVCreature *)child;

@end
