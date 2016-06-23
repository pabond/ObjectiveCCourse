//
//  BPVStringsAlphabet.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAlphabet.h"

@interface BPVStringsAlphabet : BPVAlphabet
@property (nonatomic, readonly) NSArray *strings;

- (instancetype)initWithStrings:(NSArray *)strings;

@end
