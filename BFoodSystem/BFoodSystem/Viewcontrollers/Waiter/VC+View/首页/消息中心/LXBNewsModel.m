//
//  LXBNewsModel.m
//
//
//  Created by mac on 2017/4/10.
//  Copyright © 2017年 binbin. All rights reserved.
//

#import "LXBNewsModel.h"

@implementation LXBNewsModel


-(void)setMessage:(NSString *)message{
	//在这里计算高度
    _message = message;
    if (message == nil) {
        
        return;
    }else {
        
        float width= [UIScreen mainScreen].bounds.size.width-60;
        CGSize size = [message boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_FONTSIZE_a2]} context:nil].size;
        _cellHeight = size.height + 105;
    }
    
}
@end
