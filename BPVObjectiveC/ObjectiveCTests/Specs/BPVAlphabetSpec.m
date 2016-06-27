//
//  BPVAlphabetSpec.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "Kiwi.h"

#import "BPVRangeAlphabet.h"
#import "BPVClusterAlphabet.h"
#import "BPVStringsAlphabet.h"

#import "NSString+BPVExtensions.h"

SPEC_BEGIN(BPVAlphabetTest);

describe(@"BPVAlphabet", ^{
    __block BPVAlphabet *stringsAlphabet = nil;
    
    context(@"strings alphabet test", ^{
        beforeAll(^{
            NSString *upperCaseString = [NSString stringWithFormat:@"PAVEL"];
            NSString *lowerCaseString = [NSString stringWithFormat:@"developer"];
            NSString *numbersString = [NSString stringWithFormat:@"85"];
            NSArray *strings = @[upperCaseString, numbersString, lowerCaseString];
            stringsAlphabet = [BPVStringsAlphabet alphabethWithStrings:strings];
        });
        
        it(@"class: BPVStringsAlphabet kind", ^{
            [[stringsAlphabet should] beKindOfClass:[BPVStringsAlphabet class]];
        });
        
        it(@"contain 3 strings", ^{
            [[theValue([stringsAlphabet count]) should] equal:theValue(3)];
        });
    });
    
    __block BPVAlphabet *rangeAlphabet = nil;
    
    context(@"strings alphabet test", ^{
        beforeAll(^{
            rangeAlphabet = [BPVRangeAlphabet alphabethWithRange:NSMakeRange('a','d' - 'a')];
        });
        
        it(@"class: BPVRangeAlphabet kind", ^{
            [[rangeAlphabet should] beKindOfClass:[BPVRangeAlphabet class]];
        });
        
        it(@"contain 3 strings", ^{
            [[theValue([rangeAlphabet count]) should] equal:theValue(4)];
        });
    });
    
    __block BPVAlphabet *clusterAlphabet = nil;
    
    context(@"cluster alphabet test", ^{
        beforeAll(^{
            NSArray *objects = @[stringsAlphabet, stringsAlphabet, stringsAlphabet];
            clusterAlphabet = [BPVClusterAlphabet alphabethWithStrings:objects];
        });
        
        it(@"class: BPVClustarAlphabet kind", ^{
            [[clusterAlphabet should] beKindOfClass:[BPVClusterAlphabet class]];
        });
    });
});

SPEC_END
