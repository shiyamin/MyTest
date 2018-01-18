//
//  BFQueryBalanceCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryBalanceCell.h"

@implementation BFQueryBalanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    self.titleLab.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    self.titleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.titleLab.text = @"提现日期：";
    
    self.detailLab.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.detailLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.detailLab.text = @"提现金额：";
    
    self.payProfitLab.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.payProfitLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.payProfitLab.text = @"手续费：";
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
}


- (void)setBackgroundIamge:(NSString *)imageName{
    [self.backImageView setImage:[UIImage imageNamed:imageName]];
}


- (void)configTtile:(NSString *)titleStr detailLableText:(NSString *)detailStr andPayProfitMoney:(NSString *)profitMoney{
    self.titleLab.text = [NSString stringWithFormat:@"提现日期：%@",titleStr];
    self.detailLab.text = [NSString stringWithFormat:@"%@",detailStr];
    self.payProfitLab.text = [NSString stringWithFormat:@"手续费：%@元",StringValue(profitMoney)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
