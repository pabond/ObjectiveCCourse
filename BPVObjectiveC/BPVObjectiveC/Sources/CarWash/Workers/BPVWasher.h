//
//  BPVWasher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

@interface BPVWasher : BPVWorker
@property (nonatomic, copy) NSString *name;

- (void)washCar:(id)car;

@end
