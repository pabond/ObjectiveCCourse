//
//  BPVSupportEntity.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVComplexDispatcher.h"

typedef void(^BPVSupportingBlock)(void);

@interface BPVSupportEntity : NSObject
@property (nonatomic, copy)     BPVSupportingBlock      block;
@property (nonatomic, retain)   BPVComplexDispatcher    *object;

+ (instancetype)objectWithBlock:(void(^)())block object:(BPVComplexDispatcher *)object;

- (void)performBlock;

@end
