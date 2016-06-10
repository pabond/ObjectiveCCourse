//
//  BPVCreature.h
//  ObjectiveC
//
//  Created by Bondar Pavel on 6/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVCreature : NSObject

@property (nonatomic, copy)     NSString  *name;
@property (nonatomic, assign)   NSInteger age;
@property (nonatomic, assign)   float     waight;

- (void)sayHi;
- (void)performGenderSpecificOperation;

@end
