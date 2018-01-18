//
//  BFTakeMoneyCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/6/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTakeMoneyCell.h"

@implementation BFTakeMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    self.titleLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    self.titleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    
    self.detailLab.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    self.detailLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
}


- (void)configTitle:(NSString *)titleStr detail:(NSString *)detailStr{
    self.titleLab.text = titleStr;
    self.detailLab.text = detailStr;
}

- (void)setCellSelectStatus:(BOOL)isSelect{
    if (isSelect) {
        [self.selectImageView setImage:[UIImage imageNamed:@"dm_xuanzhong"]];
    }else{
        [self.selectImageView setImage:[UIImage imageNamed:@"dm_xuanzhong_not"]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
