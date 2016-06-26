//
//  BPVRangeAlphabet.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRangeAlphabet.h"

@interface BPVRangeAlphabet ()
@property (nonatomic, assign) NSRange range;

@end

@implementation BPVRangeAlphabet

#pragma mark -
#pragma mark Deallocation/Initialisation

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    if (self) {
        self.range = range;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementation

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%c", (unichar)(self.range.location + index)];
}

@end
