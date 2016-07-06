//
//  main.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVComplex.h"
#import "BPVCar.h"

#import "NSObject+BPVExtensions.h"

static const NSUInteger kBPVCarsCount = 40;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BPVComplex *complex = [BPVComplex object];
        
        for (NSUInteger count = 0; count < kBPVCarsCount; count++) {
            [complex washCar:[BPVCar object]];
        }
    }
    
    return 0;
}
