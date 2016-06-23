//
//  BPVMoneyFlow.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

static const uint8_t kBPVCarWashPrice = 2;

@protocol BPVMoneyFlow <NSObject>
@property (nonatomic, readonly) NSUInteger money;

- (NSUInteger)giveMoney;

@optional
- (void)acceptMoney:(NSUInteger)value;
- (void)takeMoneyFromObject:(id<BPVMoneyFlow>)object;

@end
