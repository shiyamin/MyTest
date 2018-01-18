//
//  BFShopDetailModel.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopDetailModel.h"

@implementation BFShopDetailModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.shopId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.shopDescription = value;
    }
    if ([key isEqualToString:@"pic_url"]) {
        self.picArr = value;
    }
    if ([key isEqualToString:@"merchant"]) {
        self.merchantModel = [[BFMerchantModel alloc] init];
        [self.merchantModel setValuesForKeysWithDictionary:(NSDictionary *)value];
    }
    if ([key isEqualToString:@"tag_list"]) {
        self.tagArr = value;
    }
    if ([key isEqualToString:@"withdrawSet"]) {
        NSArray *dataArr = (NSArray *)value;
        self.profitArr = [NSMutableArray array];
        for (NSDictionary *proDic in dataArr) {
            BFProfitModel *model = [[BFProfitModel alloc] init];
            [model setValuesForKeysWithDictionary:proDic];
            [self.profitArr addObject:model];
        }
    }

}







@end
