//
//  main.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/10/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVCreature.h"
#import "BPVCreatureMale.h"
#import "BPVCreatureFemale.h"

#import "NSObject+BPVExtensions.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *creatures = [NSMutableArray object];
        
        BPVCreatureMale *creature = [BPVCreatureMale object];
        creature.name = @"Alex";
        [creatures addObject:creature];
        
        creature = [BPVCreatureMale object];
        creature.name = @"Paul";
        [creatures addObject:creature];
        
        creature = [BPVCreatureMale object];
        creature.name = @"Bob";
        [creatures addObject:creature];
        
        creature = [BPVCreatureFemale object];
        creature.name = @"Irene";
        [creatures addObject:creature];
        
        creature = [BPVCreatureFemale object];
        creature.name = @"Alexandra";
        [creatures addObject:creature];
        
        for (uint8_t iterations = 0; iterations < creatures.count - 1; iterations++) {
            [creature addChild:creatures[iterations]];
        }
        
        for (BPVCreature *creature in creatures) {
            [creature performGenderSpecificOperation];
            [creature allSayHi];
        }
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
