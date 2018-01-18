//
//  BFUserInfoModel.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/7.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFUserInfoModel.h"

@implementation BFUserInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.personId = value;
    }
    if ([key isEqualToString:@"headimg_url"]) {
        self.headimgurl = value;
    }
  
}

@end
