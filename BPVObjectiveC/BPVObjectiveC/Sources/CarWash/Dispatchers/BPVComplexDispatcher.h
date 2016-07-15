//
//  BPVComplexDispatcher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVComplexDispatcher : NSObject
@property (nonatomic, assign) NSTimer *timer;

+ (instancetype)disptcherWithComplex:(id)complex;
- (void)washCars;
- (void)onTimer;

@end
