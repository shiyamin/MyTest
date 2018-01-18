//
//  BFOffSaleCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFOffSaleCell.h"

@implementation BFOffSaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    NSArray *labArr = @[self.timeLable,self.foodNameLabel,self.priceLable,self.numLable,self.payMoneyLable,self.waiterLable,self.reasionLable];
    for (UILabel *lab in labArr) {
        lab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        lab.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    self.timeLable.text = @"时间";
    self.foodNameLabel.text = @"菜品";
    self.priceLable.text = @"单价";
    self.numLable.text = @"数量";
    self.payMoneyLable.text = @"金额";
    self.waiterLable.text = @"操作人";
    self.reasionLable.text = @"撤销原因:";
    
}

- (void)hiddenReasionLable{
    self.reasionLable.hidden = YES;
}


- (void)configCellWtihTime:(NSString *)timeStr foodName:(NSString *)nameStr foodPrice:(NSString *)priceStr payMoney:(NSString *)moneyStr waiterName:(NSString *)waiterName reasionInfo:(NSString *)reasion andBuyNum:(NSString *)numStr{
    self.timeLable.text = [timeStr substringWithRange:NSMakeRange(5, 11)];
    self.foodNameLabel.text = nameStr;
    self.priceLable.text = [NSString stringWithFormat:@"%@元",priceStr];
    self.payMoneyLable.text = moneyStr;
    self.waiterLable.text = waiterName;
    self.reasionLable.text = reasion;
    self.numLable.text = [NSString stringWithFormat:@"%@人",numStr];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
