//
//  BPVClusterAlphabet.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVClusterAlphabet.h"

@interface BPVClusterAlphabet ()
@property (nonatomic, retain) NSArray *alphabets;
@property (nonatomic, assign) NSUInteger count;

- (void)initCountWithAlphabets:(NSArray *)alphabets;

@end

@implementation BPVClusterAlphabet

#pragma mark -
#pragma mark Deallocations / Initialisations

- (void)dealloc {
    self.alphabets = nil;
    
    [super dealloc];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    self = [super init];
    if (self) {
        self.alphabets = alphabets;
        [self initCountWithAlphabets:alphabets];
    }
    
    return self;
}

- (void)initCountWithAlphabets:(NSArray *)alphabets {
    NSUInteger count = 0;
    
    for (BPVAlphabet *alphabet in alphabets) {
        count += alphabet.count;
    }
    
    self.count = count;
}

@end
