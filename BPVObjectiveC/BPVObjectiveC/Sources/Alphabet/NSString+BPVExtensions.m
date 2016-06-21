//
//  NSString+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSString+BPVExtensions.h"

static const NSUInteger kNSSrtingDefouldRandomStringLength = 30;

@implementation NSString (BPVExtentions)

+ (instancetype)alfanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self letterAlphabet]];
    [result appendString:[self numericAlphabet]];
     
    return [self stringWithString:result];
}

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('0', '9' - '0')];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('a', 'z' - 'a' + 1)];
}

+ (instancetype)uppercaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange('A', 'Z' - 'A' + 1)];
}


+ (instancetype)letterAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self lowercaseLetterAlphabet]];
    [result appendString:[self uppercaseLetterAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar character = range.location; character < NSMaxRange(range); character++) {
        [result appendFormat:@"%c", character];
    }
    
    return [self stringWithString:result];
}

+ (instancetype)randomString {
    return [self randomStringWithLength:arc4random_uniform(kNSSrtingDefouldRandomStringLength)];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length alphabet:[self alfanumericAlphabet]];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet {
    NSMutableString *result = [NSMutableString stringWithCapacity:length];
    NSUInteger alphabetLength = [alphabet length];
    
    for (NSUInteger iteration = 0; iteration < length; iteration++) {
        unichar resultChar = [alphabet characterAtIndex:arc4random_uniform((u_int32_t)alphabetLength)];
        [result appendFormat:@"%c", resultChar];
    }
    
    return [self stringWithString:result];
}


@end
