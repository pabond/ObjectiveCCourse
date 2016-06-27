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
    return [[[self alloc] initWithRange:range] autorelease];
}

+ (instancetype)alphabethWithStrings:(NSArray *)strings {
    return [[[self alloc] initWithStrings:strings] autorelease];
}

+ (instancetype)alphabethWithAlphabets:(NSArray *)alphabets {
    return [[[self alloc] initWithAlphabets:alphabets] autorelease];
}

+ (instancetype)alphabethWithSymbols:(NSString *)string {
    return [[[self alloc] initWithString:string] autorelease];
}

#pragma mark -
#pragma mark Deallocation / Initialisation

- (instancetype)initWithRange:(NSRange)range {
    [self release];
    
    return [[BPVRangeAlphabet alloc] initWithRange:range];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    [self release];
    
    return [[BPVStringsAlphabet alloc] initWithAlphabets:strings];
}

- (instancetype)initWithAlphabets:(NSArray *)alphabets {
    [self release];
    
    return [[BPVClusterAlphabet alloc] initWithAlphabets:alphabets];
}

- (instancetype)initWithSymbols:(NSString *)string {
    return [self initWithStrings:[string symbols]];
}

#pragma mark -
#pragma mark Public Implementation
// should be overwritten
- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

// should be overwritten
- (NSString *)stringAtIndex:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self stringAtIndex:index];
}

- (NSString *)string {
    NSMutableString *string = [NSMutableString string];
    for (NSString *symbols in self) {
        [string appendString:symbols];
    }
    
    return [[string copy] autorelease];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id[])buffer
                                    count:(NSUInteger)length
    /*
     typedef struct {
     unsigned long state;
     id __unsafe_unretained __nullable * __nullable itemsPtr;
     unsigned long * __nullable mutationsPtr;
     unsigned long extra[5];
     } NSFastEnumerationState;
     
     @protocol NSFastEnumeration
     */
{
    NSUInteger stackCount = state->extra[1] + length;
    NSUInteger count = self.count;
    NSUInteger maxCount = stackCount < count ? stackCount : count;
    length = maxCount - state->extra[1];
    
    if (length) {
        for (NSUInteger index = 0; index < maxCount; index++) {
            buffer[index] = self[index + state->extra[1]];
        }
    }
    
    state->itemsPtr = buffer;
    
    state->extra[1] += length;
    
    return length;
}


@end

