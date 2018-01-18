//
//  BFPrintOrderModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/6/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFPrintOrderModel.h"

@implementation BFPrintOrderModel

- (NSDictionary *)deskDic{
    if (!_deskDic) {
        _deskDic = [NSDictionary dictionary];
    }
    return _deskDic;
}

- (NSMutableArray *)dishesArr{
    if (!_dishesArr) {
        _dishesArr = [NSMutableArray array];
    }
    return _dishesArr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
