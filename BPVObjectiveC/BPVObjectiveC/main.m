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
 // наблюдатель и делегат
 // контроллирующий класс более высокого уровня
 
 Задание 6.
 Условие:
 Есть иерархия сотрудников из задания 3 cо следующими ограничениями:
 1. 1 мойщик моет одну машину за раз
 2. На всем предприятии есть рандомное количество мойщиков, один бухгалтер и один директор
 3. Выкинуть сами здания
 Задание:
 Реализовать иерархию классов с наблюдением за состоянием со следующим потоком денег: машина заезжает на мойку, после мытья машины мойщик берет деньги у машины, сообщает бухгалтеру, что получил деньги, бухгалтер забирает деньги у мойщика, бухгалтер считает и после этого сообщает директору, что посчитал деньги, и директор их забирает.

*/
