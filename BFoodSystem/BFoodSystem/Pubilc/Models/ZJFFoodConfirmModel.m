//
//  ZJFFoodConfirmModel.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/18.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFFoodConfirmModel.h"

@implementation ZJFFoodConfirmModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.orderID = value;
    }
    
    if ([key isEqualToString:@"create_date"]) {
        self.createDate = value;
    }
    
    if ([key isEqualToString:@"shop_id"]) {
        self.shopId = value;
    }
    
    if ([key isEqualToString:@"desk_id"]) {
        self.deskId = value;
    }
    
    if ([key isEqualToString:@"dishes_list"]) {
        self.dishesArr = value;
    }
    
}


@end
