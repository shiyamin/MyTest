//
//  BFFoodSaleModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodSaleModel.h"

@implementation BFFoodSaleModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"dishes"]) {
        if ([[value class] isSubclassOfClass:[NSDictionary class]]) {
            self.foodModel = [[BFFoodModel alloc] init];
            [self.foodModel setValuesForKeysWithDictionary:value];
        }
    }
}

@end
