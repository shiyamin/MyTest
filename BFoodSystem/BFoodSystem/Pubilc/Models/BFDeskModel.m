//
//  BFDeskModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskModel.h"

@implementation BFDeskModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.deskId = value;
    }
}





@end
