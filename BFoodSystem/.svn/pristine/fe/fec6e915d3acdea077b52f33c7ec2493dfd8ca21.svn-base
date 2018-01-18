//
//  BFAreaTabbleCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAreaTabbleCell.h"


@implementation BFAreaTabbleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubviews];
}

- (void)setStatusForSubviews{
//    self.leftLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
//    self.leftLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.areaTextField.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.areaTextField.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.areaTextField.layer.borderColor = [UIColor clearColor].CGColor;
    
    
    
}






- (IBAction)delectBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabbleViewCellDelectBtnAction:)]) {
        [self.delegate tabbleViewCellDelectBtnAction:sender];
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
