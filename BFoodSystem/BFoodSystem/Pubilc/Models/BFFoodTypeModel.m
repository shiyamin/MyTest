//
//  BFFoodTypeModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/30.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodTypeModel.h"

@implementation BFFoodTypeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.foodClassId = value;
    }
}




@end
