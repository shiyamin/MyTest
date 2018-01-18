//
//  LXBDishes_listModel.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "LXBCookingdetailModel.h"

@implementation LXBCookingdetailModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.dishesID = value;
    }
}
- (void)setRemark:(NSString *)remark
{
    //在这里计算高度
    _remark = remark;
    float width= [UIScreen mainScreen].bounds.size.width - 20;
    CGSize size = [remark boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_FONTSIZE_a2]} context:nil].size;
    _cellHeight = size.height + 88;
}

@end
