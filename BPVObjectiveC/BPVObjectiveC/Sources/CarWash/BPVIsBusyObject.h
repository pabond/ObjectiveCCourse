//
//  BPVIsBusyObject.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPVIsBusyObject <NSObject>
@property (nonatomic, assign, getter=isBusy) BOOL busy;

@end
