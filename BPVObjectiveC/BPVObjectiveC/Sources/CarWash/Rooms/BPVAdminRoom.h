//
//  BPVAdminRoom.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVAdminRoom : NSObject
@property (nonatomic, readonly) NSArray *workers;

@property (nonatomic, assign, getter=isFull) BOOL full;

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;
- (id)freeWorkerWithClass:(Class)cls;

@end