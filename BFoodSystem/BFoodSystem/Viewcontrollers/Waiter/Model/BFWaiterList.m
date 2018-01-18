//
//  BFWaiterList.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/7.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterList.h"

@implementation BFWaiterList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.waiteID = value;
    }
}


@end
