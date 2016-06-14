//
//  BPVBuilding.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVBuilding : NSObject
@property (nonatomic, readonly) NSArray *rooms;

- (void)addRoom:(id)room;
- (void)removeRoom:(id)room;


@end
