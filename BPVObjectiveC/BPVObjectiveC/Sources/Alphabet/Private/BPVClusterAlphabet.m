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
    NSArray *alphabetAtIndex = nil;
    for (NSInteger index = 0; index < alphabets.count; index++) {
        alphabetAtIndex = alphabets[index];
        count += alphabetAtIndex.count;
    }
    
    self.count = count;
}

#pragma mark -
#pragma mark Public Implementation

- (NSString *)stringAtIndex:(NSUInteger)index {
    if (index < self.count) {
        NSUInteger clusterCount = 0;
        for (BPVAlphabet *alphabet in self.alphabets) {
            clusterCount = [alphabet count];
            if (index < clusterCount) {
                return alphabet[index];
            }
            
            index -= clusterCount;
        }
    }
    
    return nil;
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString stringWithCapacity:self.count];
    for (BPVAlphabet *alphabet in self.alphabets) {
        [string appendString:[alphabet string]];
    }
    
    return [[string copy] autorelease];
}

//should be called parrent fast enumeration

@end
