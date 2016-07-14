//
//  main.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVComplexDipatcher.h"

#import "NSObject+BPVExtensions.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BPVComplexDipatcher *complexDispatcher = [BPVComplexDipatcher object];
        [complexDispatcher washCars];
        
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}
