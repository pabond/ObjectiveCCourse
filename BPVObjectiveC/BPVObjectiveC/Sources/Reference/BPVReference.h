//
//  BPVReference.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVReference : NSObject <NSCopying>
@property (nonatomic, readonly) id target;

+ (instancetype)referenceWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

- (BOOL)isEqualToReference:(id)reference;

@end
