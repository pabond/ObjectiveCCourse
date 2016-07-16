//
//  BPVComplexDispatcher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVComplexDispatcher : NSObject
@property (nonatomic, readonly, getter=isRunning) BOOL running;

+ (instancetype)disptcherWithComplex:(id)complex;

- (void)setRunning:(BOOL)running;

- (void)washCars;


@end
