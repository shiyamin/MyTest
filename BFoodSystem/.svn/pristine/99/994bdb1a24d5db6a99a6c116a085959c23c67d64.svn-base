//
//  BFMessageModel.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//



#import "BFMessageListModel.h"

@implementation BFMessageListModel

- (NSDictionary *)data{
    if (!_data) {
        _data = [NSDictionary dictionary];
    }
    return _data;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.messageId = value;
    }
    
    if ([key isEqualToString:@"create_date"]) {
        self.creatTime = value;
    }
    
    if ([key isEqualToString:@"pic_url"]) {
        self.picurl = value;
    }
    
    if ([key isEqualToString:@"taget_id"]) {
        self.tagetID = value;
    }
    
    
    if ([key isEqualToString:@"taget_type"]) {
        self.tagetType = value;
    }
    
}

- (void)setContent:(NSString *)content{
    //在这里计算高度
    _content = content;
    float width= [UIScreen mainScreen].bounds.size.width-20;
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_FONTSIZE_a2]} context:nil].size;
    _cellHeight = size.height + 50;
}


@end
