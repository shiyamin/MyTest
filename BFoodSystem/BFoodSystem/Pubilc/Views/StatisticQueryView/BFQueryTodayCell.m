//
//  BFQueryTodayCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryTodayCell.h"

@implementation BFQueryTodayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}


- (void)setStatusForSubViews{
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    
    NSArray *lableArr = @[self.orderLable,self.personNumLable,self.personMoneyLable,self.orderMoneyLable,self.totalMonyLable,self.incomeTitleLable,self.platformLabel,self.cashierLable,self.wechatLable,self.payLable,self.bankLable,self.menberLable,self.groupBuyLable];
    for (UILabel *lable in lableArr) {
        lable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        lable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    
    self.dataLable.textColor = [UIColor colorWithHex:BF_COLOR_B11];
    self.dataLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    
    self.dataLable.text = @"日期：";
    self.orderLable.text = @"订单数：";
    self.personNumLable.text = @"点餐总人数：";
    self.personMoneyLable.text = @"人均消费：";
    self.orderMoneyLable.text = @"订单平均金额：";
    self.totalMonyLable.text = @"总收入：";
    self.incomeTitleLable.text = @"收益去向：";
    self.platformLabel.text = @"平台：";
    self.cashierLable.text = @"现金：";
    self.wechatLable.text = @"微信：";
    self.payLable.text = @"支付宝：";
    self.bankLable.text = @"银行卡：";
    self.menberLable.text = @"会员：";
    self.groupBuyLable.text = @"美团：";
    
}


- (void)configCellWithDailyModel:(BFQueryDailyModel *)model{
    self.dataLable.text = [NSString stringWithFormat:@"日期：%@",model.create_date];
    self.orderLable.text = [NSString stringWithFormat:@"订单数：%@单",model.orders];
    self.personNumLable.text = [NSString stringWithFormat:@"点餐总人数：%@人",model.diner];
    self.personMoneyLable.text = [NSString stringWithFormat:@"人均消费：%@元",model.perDiner];
    self.orderMoneyLable.text = [NSString stringWithFormat:@"订单平均金额：%@元",model.perOrder];
    self.totalMonyLable.text = [NSString stringWithFormat:@"总收入：%@元",model.total];
    self.platformLabel.text = [NSString stringWithFormat:@"平台：%@元",model.platform];
    self.cashierLable.text = [NSString stringWithFormat:@"现金：%@元",model.cash];
    self.wechatLable.text = [NSString stringWithFormat:@"微信：%@元",model.weixin];
    self.payLable.text = [NSString stringWithFormat:@"支付宝：%@元",model.alipay];
    self.bankLable.text = [NSString stringWithFormat:@"银行卡：%@元",model.bank];
    self.menberLable.text = [NSString stringWithFormat:@"会员：%@元",model.member];
    self.groupBuyLable.text = [NSString stringWithFormat:@"美团：%@元",model.meituan];



}


- (void)setBackgroundIamge:(NSString *)imageName{
    [self.backImageView setImage:[UIImage imageNamed:imageName]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
