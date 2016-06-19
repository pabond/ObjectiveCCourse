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

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;

- (NSArray *)workersWithClass:(Class)cls;

@end