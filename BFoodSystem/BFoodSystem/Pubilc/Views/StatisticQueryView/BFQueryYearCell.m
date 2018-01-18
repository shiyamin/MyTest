//
//  BFQueryYearCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryYearCell.h"

@implementation BFQueryYearCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}


- (void)setStatusForSubViews{
    NSArray *lableArr = @[self.dataLable, self.orderLable,self.personNumLable,self.personMoneyLable,self.orderMoneyLable,self.totalMonyLable,self.incomeTitleLable,self.platformLabel,self.cashierLable,self.wechatLable,self.payLable,self.bankLable,self.menberLable,self.groupBuyLable];
    for (UILabel *lable in lableArr) {
        lable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        lable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    self.dataLable.text = @"经营情况查询：";
    self.orderLable.text = @"订单数：0单";
    self.personNumLable.text = @"点餐总人数：0人";
    self.personMoneyLable.text = @"人均消费：0元";
    self.orderMoneyLable.text = @"订单平均金额：0元";
    self.totalMonyLable.text = @"总收入：0元";
    self.incomeTitleLable.text = @"收益去向：";
    self.platformLabel.text = @"平台：0元";
    self.cashierLable.text = @"现金：0元";
    self.wechatLable.text = @"微信：0元";
    self.payLable.text = @"支付宝：0元";
    self.bankLable.text = @"银行卡：0元";
    self.menberLable.text = @"会员：0元";
    self.groupBuyLable.text = @"美团：0元";


}

- (void)configCellWtihMdoel:(BFQueryDailyModel *)model{
    
    if (isStringEmpty(model.orders)) {
        model.orders = @"0";
    }
    if (isStringEmpty(model.diner)) {
        model.diner = @"0";
    }
    if (isStringEmpty(model.perDiner)) {
        model.perDiner = @"0";
    }
    if (isStringEmpty(model.perOrder)) {
        model.perOrder = @"0";
    }
    if (isStringEmpty(model.total)) {
        model.total = @"0";
    }
    if (isStringEmpty(model.platform)) {
        model.platform = @"0";
    }
    if (isStringEmpty(model.cash)) {
        model.cash = @"0";
    }
    if (isStringEmpty(model.weixin)) {
        model.weixin = @"0";
    }
    if (isStringEmpty(model.alipay)) {
        model.alipay = @"0";
    }
    if (isStringEmpty(model.bank)) {
        model.bank = @"0";
    }
    if (isStringEmpty(model.member)) {
        model.member = @"0";
    }
    if (isStringEmpty(model.meituan)) {
        model.meituan = @"0";
    }
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



- (void)configTitleWith:(NSString *)beginStr endTime:(NSString *)endStr{
    self.dataLable.text = [NSString stringWithFormat:@"您在%@至%@期间，经营情况如下：",beginStr,endStr];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
