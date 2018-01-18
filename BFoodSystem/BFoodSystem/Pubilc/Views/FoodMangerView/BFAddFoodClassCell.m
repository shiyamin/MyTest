//
//  BFFoodTableViewCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAddFoodClassCell.h"

@implementation BFAddFoodClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}


- (void)setStatusForSubViews{
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 1;
    
    self.foodNameLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.foodNameLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    
    self.foodLevelTf.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.foodLevelTf.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.foodLevelTf.userInteractionEnabled = NO;
//    self.foodLevelTf.layer.borderWidth = 1;
//    self.foodLevelTf.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

- (void)setFoodClassName:(NSString *)namestr andLevel:(NSString *)level delectBtnTag:(NSInteger)tag{
    
    self.foodNameLable.text = namestr;
    self.foodLevelTf.text =[NSString stringWithFormat:@"%@",level];
    self.delectBtn.tag = tag;
}


- (void)hiddenDeleteBtn:(BOOL )isHidden{
    self.delectBtn.hidden = !isHidden;
}

- (IBAction)delectBtnAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(delectBtnAction:index:)]) {
        [self.delegate delectBtnAction:sender index:sender.tag];
    }
    
    
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
