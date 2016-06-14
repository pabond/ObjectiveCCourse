//
//  BPVWasher.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

#import "BPVCar.h"

@interface BPVWasher : BPVWorker

- (void)washCar:(BPVCar *)car;

@end
