//
//  BFWaiterTableCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterTableCell.h"

@implementation BFWaiterTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubviews];
}


- (void)setStatusForSubviews{
    self.nameLab.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.nameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    
    self.responsAreaLable.textColor = [UIColor colorWithHex:BF_COLOR_B16];
    self.responsAreaLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
    [self bringSubviewToFront:self.responsAreaLable];
    [self.headImageView setImage:[UIImage imageNamed:@"xzdy_touxiang"]];
}


- (void)configPersonName:(NSString *)nameStr personOpsition:(NSString *)opsition headIcon:(NSString *)iconStr loginType:(NSInteger)type{     self.nameLab.text = nameStr;
    if (![iconStr isEqualToString:@""]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:iconStr]];
    }
    self.responsAreaLable.text = @"";
    if (type == 3) {
        return;
    }
    self.responsAreaLable.text = opsition;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
