//
//  BFUserAmountModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFUserAmountModel.h"

@implementation BFUserAmountModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.amountId = value;
    }
}






@end
