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

/*
 Задание 4.
 Написать расширения для строки, которая бы генерировалась случайным образом.
 ТРебования:
 1. должна быть расширяемой
 2. должна быть удобной
 3. должна предоставлять возможность работать с разными наборами символов
 
 // контроллирующий класс более высокого уровня
 // Kiwi
 // блок, синтаксис блока
 // __block переменная
 // NSFastEnumeration
 
 Задание 5.
 Написать класс, реализующий обертку над алфавитом или набором символов
 Требования:
 1. не должен быть наследником nsarray
 2. может быть динамическим или работать с набором символов
 3. должен быть кластерным классом
 4. должен уметь NSFastEnumeration
*/
