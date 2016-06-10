//
//  BPVAdminRoom.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAdminRoom.h"

@implementation BPVAdminRoom

- (void)dealloc {
    self.director = nil;
    self.accountant = nil;
    
    [super dealloc];
}

@end
