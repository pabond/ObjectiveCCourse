//
//  BPVStringsAlphabet.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVStringsAlphabet.h"

@interface BPVStringsAlphabet ()
@property (nonatomic, retain) NSArray *strings;

@end

@implementation BPVStringsAlphabet

#pragma mark -
#pragma mark Deallocation / Initialisation


- (void)dealloc {
    self.strings = nil;
    
    [super dealloc];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    self = [super init];
    if (self) {
        self.strings = strings;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.strings.count;
}

#pragma mark -
#pragma mark Public

- (NSString *)stringAtIndex:(NSUInteger)index {
    return self.strings[index];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id [])buffer
                                    count:(NSUInteger)len
{
    return [self.strings countByEnumeratingWithState:state
                                             objects:buffer
                                               count:len];
}

@end
