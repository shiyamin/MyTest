//
//  LXBOrder_listModel.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "LXBOrder_listModel.h"

@implementation LXBOrder_listModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.order_id = value;
    }
}

@end
