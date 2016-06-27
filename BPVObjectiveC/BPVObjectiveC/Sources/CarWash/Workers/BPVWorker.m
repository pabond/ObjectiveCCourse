//
//  BPVWorker.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

#import "NSObject+BPVExtensions.h"

@interface BPVWorker ()
@property (nonatomic, assign) NSUInteger    money;

@end

@implementation BPVWorker

- (void)dealloc {
    self.delegatingObject = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark BPVMoneyFlow

- (void)acceptMoney:(NSUInteger)value {
    self.money += value;
}

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

- (void)takeMoneyFromObject:(id<BPVMoneyFlow>)object {
    [self acceptMoney:[object giveMoney]];
}

- (void)processObject:(id)object {
    self.busy = YES;
    [self performWorkWithObject:object];
    [self.delegate workerDidFinishProcessingObject:self];
    self.busy = NO;
}

- (void)performWorkWithObject:(id)object {
    NSLog(@"Selector:\"performWorkWithObject\" should be launched in child classes");
}

@end
