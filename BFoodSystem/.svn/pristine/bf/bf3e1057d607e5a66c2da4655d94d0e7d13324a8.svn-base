//
//  BFFoodModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/29.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodModel.h"
#import "BFFoodTypeModel.h"


@implementation BFFoodModel


- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.foodId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.foodDescription = value;
    }
    if ([key isEqualToString:@"type_list"]) {
        if ([[value class] isSubclassOfClass:[NSArray class]]) {
            for (NSDictionary *typeDic in value) {
                BFFoodTypeModel *typeModel = [[BFFoodTypeModel alloc] init];
                [typeModel setValuesForKeysWithDictionary:typeDic];
                [self.typeArr addObject:typeModel];
            }
        }
    }
    
    
}




@end
