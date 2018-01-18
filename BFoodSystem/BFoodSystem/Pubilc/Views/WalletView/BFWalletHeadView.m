//
//  BFWalletHeadView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWalletHeadView.h"

@implementation BFWalletHeadView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setStatusForSubViews];
    
}

- (void)setStatusForSubViews{
    self.totalMoneyTitleLab.textColor = [UIColor whiteColor];
    self.totalMoneyTitleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    self.totalMoneyTitleLab.text = @"当前账户总余额（元）";
    
//    self.totalMoneyNumLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a5];
    self.totalMoneyNumLab.textColor = [UIColor whiteColor];
    
    self.leftTitle.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.leftTitle.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.leftTitle.text = @"可提现金额（元）";
    
    self.leftNum.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    self.leftNum.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    
    self.rightTitle.font= [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.rightTitle.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.rightTitle.text = @"已提现金额（元）";
    
    self.rightNum.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    self.rightNum.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    
}


- (void)configTotalMoney:(NSString *)moneyStr leftMoney:(NSString *)leftStr rightMoney:(NSString *)rightStr{
    self.totalMoneyNumLab.text = [NSString stringWithFormat:@"%@元",moneyStr];
    self.leftNum.text = [NSString stringWithFormat:@"%@元",leftStr];
    self.rightNum.text = [NSString stringWithFormat:@"%@元",rightStr];
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
