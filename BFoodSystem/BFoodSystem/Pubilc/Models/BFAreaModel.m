//
//  BFAreaModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAreaModel.h"

@implementation BFAreaModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.areaId = value;
    }
}


@end
