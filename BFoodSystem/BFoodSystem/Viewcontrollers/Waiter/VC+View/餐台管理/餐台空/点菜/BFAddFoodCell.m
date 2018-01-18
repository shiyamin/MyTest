//
//  BFAddFoodCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAddFoodCell.h"

@implementation BFAddFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setStatusForSubViews];
    
}

- (void)setStatusForSubViews{
    
    self.foodName.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.foodName.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    
    self.foodPrice.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    self.foodPrice.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    
    self.foodNumLabl.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    self.foodNumLabl.layer.borderWidth = 1;
    self.foodNumLabl.text = @"0";
    
    [self.addBtn addTarget:self action:@selector(changeFoodNum:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.tag = 1;
    self.addBtn.layer.cornerRadius = 2;
    self.addBtn.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    self.addBtn.clipsToBounds = YES;
    self.addBtn.layer.borderWidth = 1;
    
    [self.delectBtn addTarget:self action:@selector(changeFoodNum:) forControlEvents:UIControlEventTouchUpInside];
    self.delectBtn.tag = 2;
    self.delectBtn.layer.cornerRadius = 2;
    self.delectBtn.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    self.delectBtn.clipsToBounds = YES;
    self.delectBtn.layer.borderWidth = 1;
    
}

- (void)changeFoodNum:(UIButton *)sender{
    
    NSInteger foodCount = [self.foodNumLabl.text integerValue];
    if (sender.tag == 1) {
        foodCount ++;
    }else{
        if(foodCount != 0 ){
            foodCount --;
        }else{
            return;
        }
    }
    self.foodNumLabl.text = [NSString stringWithFormat:@"%ld",(long)foodCount];
    if([self.delegate respondsToSelector:@selector(foodNumChangedWith:andFoodNum:isDelect:)]){
        if (sender.tag == 1) {
            [self.delegate foodNumChangedWith:self.index andFoodNum:foodCount isDelect:YES];
        }else{
            [self.delegate foodNumChangedWith:self.index andFoodNum:foodCount isDelect:NO];
        }
    }
}

- (void)configFoodName:(NSString *)foodName foodPrice:(NSString *)foodPrice foodNum:(NSString *)foodNum{
    self.foodName.text = foodName;
    self.foodPrice.text = foodPrice;
    NSString *fnum = [NSString stringWithFormat:@"%@",foodNum];
    if ([fnum isEqualToString:@""]) {
        self.foodNumLabl.text = @"0";
    }else{
        self.foodNumLabl.text = [NSString stringWithFormat:@"%@",foodNum];

    }
}

- (void)configFoodIcon:(NSString *)iconUrl{
    [self.foodIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
