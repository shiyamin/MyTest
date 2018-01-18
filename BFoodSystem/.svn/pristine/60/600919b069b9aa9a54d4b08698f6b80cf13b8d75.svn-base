//
//  BFScrollMiddleView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/15.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFScrollMiddleView.h"

@implementation BFScrollMiddleView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    
    self.saleNumLable.textColor = [UIColor colorWithHex:@"#e30211"];
    
    NSArray *titleArr = @[self.leftTitleLab,self.orderTitleLab,self.rightTitleLab];
    for (UILabel *lable in titleArr) {
        lable.textColor = [UIColor colorWithHex:@"#1a1a1a"];
        lable.font = [UIFont systemFontOfSize:12];
    }
    NSArray *numArr = @[self.leftNumLab,self.orderNumLab,self.rightNumLab];
    for (UILabel *lable in numArr) {
        lable.textColor = [UIColor colorWithHex:@"#e55c25"];
        lable.font = [UIFont systemFontOfSize:14];
    }
}


- (void)configInfoWithSaleNum:(NSString *)saleNumStr personNum:(NSString *)personNum orderNum:(NSString *)orderStr rightNum:(NSString *)rightStr{
    self.saleNumLable.text = [NSString stringWithFormat:@"%@元",saleNumStr];
    self.leftNumLab.text = [NSString stringWithFormat:@"%@人",personNum];
    self.orderNumLab.text = [NSString stringWithFormat:@"%@单",orderStr];
    self.rightNumLab.text = [NSString stringWithFormat:@"%@元",rightStr];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
