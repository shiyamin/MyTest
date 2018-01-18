//
//  BFEmployeeModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFEmployeeModel.h"

@implementation BFEmployeeModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"headimg"]) {
        self.headimgId = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.employeeId = value;
    }
}



@end
