//
//  BFMessageModel.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFMessageModel.h"

@implementation BFMessageModel

- (NSArray *)msgList{
    if (!_msgList) {
        _msgList = [NSArray array];
    }
    return _msgList;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
    if ([key isEqualToString:@"msg_list"]) {
        self.msgList = value;
    }
}

@end
