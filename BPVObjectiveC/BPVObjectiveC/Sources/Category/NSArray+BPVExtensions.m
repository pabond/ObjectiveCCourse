//
//  NSArray+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSArray+BPVExtensions.h"

#import "NSObject+BPVExtensions.h"

@implementation NSArray (BPVExtensions)

- (NSArray *)filteredUsingBlock:(BPVArrayFiltredUsingBlock)block {
    if (!block) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

+ (NSMutableArray *)arrayWithObjectsCount:(NSUInteger)count usingBlock:(id(^)())block {
    NSMutableArray *array = [NSMutableArray object];
    
    for (NSUInteger index = 0; index < count; index++) {
        [array addObject:block()];
    }
    
    return array;
}

@end
