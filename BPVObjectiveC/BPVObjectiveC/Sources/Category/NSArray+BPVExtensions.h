//
//  NSArray+BPVExtensions.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^BPVArrayFiltredUsingBlock)(id object);

@interface NSArray (BPVExtensions)

- (NSArray *)filteredUsingBlock:(BPVArrayFiltredUsingBlock)block;

@end
