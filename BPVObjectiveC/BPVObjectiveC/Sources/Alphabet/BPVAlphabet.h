//
//  BPVAlphabet.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVAlphabet : NSObject <NSFastEnumeration>

+ (instancetype)alphabethWithRange:(NSRange)range;
+ (instancetype)alphabethWithStrings:(NSArray *)strings;
+ (instancetype)alphabethWithAlphabets:(NSArray *)alphabets;
+ (instancetype)alphabethWithSymbols:(NSString *)string;

- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabets:(NSArray *)alphabets;
- (instancetype)initWithStrings:(NSArray *)strings;
- (instancetype)initWithSymbols:(NSString *)string;

- (NSUInteger)count;
- (NSString *)stringAtIndex:(NSUInteger)index;

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index;

- (NSString *)string;

@end
