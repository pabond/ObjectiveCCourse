//
//  BPVWorker.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVMoneyFlow.h"

@interface BPVWorker : NSObject <BPVMoneyFlow>
@property (nonatomic, assign)   NSUInteger  experience;
@property (nonatomic, assign)   NSUInteger  salary;
@property (nonatomic, assign)   BOOL        busy;

@end
