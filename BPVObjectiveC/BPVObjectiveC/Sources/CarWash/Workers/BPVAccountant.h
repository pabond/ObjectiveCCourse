//
//  BPVAccountant.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVWorker.h"

@interface BPVAccountant : BPVWorker <BPVWorkersDelegate, BPVWorkersObserver>

- (void)countMoney;

@end
