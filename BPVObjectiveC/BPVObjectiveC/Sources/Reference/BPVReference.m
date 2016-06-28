//
//  BPVReference.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVReference.h"

@interface BPVReference ()
@property (nonatomic, assign) id target;

@end

@implementation BPVReference

@dynamic target;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)referenceWithTarget:(id)target {
    return [[[self alloc] initWithTarget:target] autorelease];
}

#pragma mark -
#pragma mark Initialisations / Deallocations

- (void)dealloc {
    self.target = nil;
    
    [super dealloc];
}

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        self.target = target;
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public implementations

- (NSUInteger)hash {
    return (NSUInteger)self.target ^ (NSUInteger)[self class];
}

- (BOOL)isEqual:(id)object {
    BOOL result = NO;
    
    if (self == object) {
        result = YES;
    }
    
    if ([object isMemberOfClass:[self class]]) {
        result = [self isEqualToReference:object];
    }
    
    return result;
}

- (BOOL)isEqualToReference:(BPVReference *)reference {
    return self.target == reference.target;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithTarget:self.target];
}

@end
