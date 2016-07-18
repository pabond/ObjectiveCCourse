//
//  main.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVComplexDispatcher.h"
#import "BPVComplex.h"

#import "NSObject+BPVExtensions.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BPVComplexDispatcher *complexDispatcher = [BPVComplexDispatcher disptcherWithComplex:[BPVComplex object]];
        [complexDispatcher washCars];
        [complexDispatcher setRunning:YES];
        
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}
