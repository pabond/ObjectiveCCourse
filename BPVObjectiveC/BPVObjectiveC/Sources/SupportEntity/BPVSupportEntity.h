//
//  BPVSupportEntity.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^BPVSupportingBlock)(void);

@interface BPVSupportEntity : NSObject
@property (nonatomic, copy)     BPVSupportingBlock      block;

+ (instancetype)objectWithBlock:(void(^)())block;

- (void)startTimer:(NSTimer *)timer;

@end
