//
//  NSString+BPVExtentions.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPVExtentions)

+ (id)alfanumericAlphabet;
+ (id)numericAlphabet;
+ (id)lowercaseLetterAlphabet;
+ (id)uppercaseLetterAlphabet;
+ (id)letterAlphabet;

+ (id)alphabetWithUnicodeRange;
+ (id)randomString;
+ (id)randomStringWithLength:(NSUInteger)length;
+ (id)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
