//
//  BPVAlphabet.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAlphabet.h"

#import "BPVRangeAlphabet.h"
#import "BPVClusterAlphabet.h"
#import "BPVStringsAlphabet.h"

#import "NSString+BPVExtensions.h"

@implementation BPVAlphabet

#pragma mark -
#pragma mark Class Methods Implementation

+ (instancetype)alphabethWithRange:(NSRange)range {
    return [[[BPVRangeAlphabet alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabethWithStrings:(NSArray *)strings {
    return [[[BPVStringsAlphabet alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabethWithAlphabets:(NSArray *)alphabets {
    return [[[BPVClusterAlphabet alloc] initWithStrings:alphabets] autorelease];
}

+ (instancetype)alphabethWithSymbols:(NSString *)string {
    return [self alphabethWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Deallocation / Initialisation

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];

    return nil;
}

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[BPVRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[BPVClusterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[BPVStringsAlphabet alloc] initWithStrings:strings];
}
- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Public Implementation

- (NSUInteger)count {
    return 0;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return nil;
}

#pragma mark -
#pragma mark Public Implementation

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id  _Nonnull *)buffer
                                    count:(NSUInteger)length
{
    return 0;
}

@end
