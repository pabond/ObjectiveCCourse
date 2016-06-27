//
//  BPVWorkersDelegate.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPVWorkersDelegate <NSObject>

- (void)workerDidFinishProcessingObject:(id)worker;

@end
