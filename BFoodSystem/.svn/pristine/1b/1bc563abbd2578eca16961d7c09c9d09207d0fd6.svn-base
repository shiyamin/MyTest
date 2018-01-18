//
//  BFWithdrawCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWithdrawCell.h"

@implementation BFWithdrawCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    self.nameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.nameLab.textColor = [UIColor colorWithHex:BF_COLOR_L17];
    
    self.numLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.numLable.textColor = [UIColor colorWithHex:BF_COLOR_L17];
    
    self.bankNameLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.bankNameLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    
    [self.withdrawBtn setTitleColor:[UIColor colorWithHex:BF_COLOR_B11] forState:UIControlStateNormal];
    self.withdrawBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [self.withdrawBtn setTitle:@"提现到此" forState:UIControlStateNormal];
    self.withdrawBtn.layer.cornerRadius = 5;
    self.withdrawBtn.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B11].CGColor;
    self.withdrawBtn.layer.borderWidth = 1;
    self.withdrawBtn.clipsToBounds = YES;
    
    
}


- (void)configCellWithPersonName:(NSString *)nameStr bankNum:(NSString *)bankNumStr bankName:(NSString *)bankNameStr{
    self.nameLab.text = nameStr;
    self.bankNameLable.text = bankNameStr;
    self.numLable.text = bankNumStr;
}

- (IBAction)withdrawAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectWithdrawBtn:)]) {
        [self.delegate didSelectWithdrawBtn:self.indexPat];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
