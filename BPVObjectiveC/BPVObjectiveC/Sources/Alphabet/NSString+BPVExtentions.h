//
//  NSString+BPVExtentions.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPVExtentions)

+ (instancetype)alfanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)lowercaseLetterAlphabet;
+ (instancetype)uppercaseLetterAlphabet;
+ (instancetype)letterAlphabet;

+ (instancetype)alphabetWithUnicodeRange;
+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
