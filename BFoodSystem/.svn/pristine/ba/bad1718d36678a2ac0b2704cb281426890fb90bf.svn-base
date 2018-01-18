//
//  BFQueryFoodCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryFoodCell.h"

@implementation BFQueryFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    self.foodNameLabel.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.foodNameLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_B1];
    
    self.saleNumLable.textColor = [UIColor colorWithHex:BF_COLOR_B12];
    self.saleNumLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_B1];
    
    self.foodNameLabel.text = @"菜品名字";
    self.saleNumLable.text = @"";
}


- (void)configFoodName:(NSString *)nameStr saleNum:(NSString *)numStr{
    self.foodNameLabel.text = nameStr;
    self.saleNumLable.text = [NSString stringWithFormat:@"销量：%@",numStr];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
