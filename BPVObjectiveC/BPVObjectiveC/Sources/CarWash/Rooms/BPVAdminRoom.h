//
//  BPVAdminRoom.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVIsBusyObject.h"

@interface BPVAdminRoom : NSObject <BPVIsBusyObject>
@property (nonatomic, readonly) NSArray     *workers;

- (void)addWorker:(id)worker;
- (void)removeWorker:(id)worker;

@end