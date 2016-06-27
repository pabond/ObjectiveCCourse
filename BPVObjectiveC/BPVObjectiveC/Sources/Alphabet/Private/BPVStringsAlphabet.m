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
@property (nonatomic, assign) NSUInteger count;

@end

@implementation BPVStringsAlphabet

#pragma mark -
#pragma mark Deallocation/Initialisation

- (void)dealloc {
    self.strings = nil;
    
    [super dealloc];
}

- (instancetype)initWithStrings:(NSArray *)strings {
    self = [super init];
    if (self) {
        self.strings = strings;
        self.count = [self.strings count];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementation

- (NSString *)stringAtIndex:(NSUInteger)index {
    return self.strings[index];
}



- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id[])buffer
                                    count:(NSUInteger)len
{
    return [self.strings countByEnumeratingWithState:state objects:buffer count:len];
}

@end
