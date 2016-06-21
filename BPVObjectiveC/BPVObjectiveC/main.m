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
#import "BPVDirector.h"
#import "BPVBuilding.h"

#import "NSObject+BPVExtensions.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BPVComplex *complex = [BPVComplex object];
        [complex washCars];
    }
    
    return 0;
}

/*
 Задание 2.
 Условие:
 Дано существо из задания 1.
 Задание:
 1. Убрать переменную пол из существа, а также умение воевать и рожать детей;
 2. Вместо нее создать наследников существа: мужское и женское существо;
 3. Мужское существо умеет воевать, женское - рожать детей;
 4. Создать метод performGenderSpecificOperation у родительского существа, который ничего не делает, мужское существо по вызову этого метода идет воевать, женское рожает детей;
 5. Создать массив существ, в котором бы лежали только мужчины и женщины, пройтись по нему через for (Creature *creature in creatures) и вызвать метод performGenderSpecificOperation, которой, в зависимости от пола существа приведет либо к войне, либо к родам -> Подчеркнуть, что это - полиморфизм, значит, охуенно.
 6. Заменить alloc init autorelease на NSOBject категорию с методом object
 */
