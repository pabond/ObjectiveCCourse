//
//  BPVClusterAlphabet.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAlphabet.h"

@interface BPVClusterAlphabet : BPVAlphabet
@property (nonatomic, readonly) NSArray *alphabets;
@property (nonatomic, readonly) NSUInteger count;

- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (NSString *)stringAtIndex:(NSUInteger)index;

@end
