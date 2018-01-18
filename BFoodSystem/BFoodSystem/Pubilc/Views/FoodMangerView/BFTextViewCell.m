//
//  BFTextViewCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTextViewCell.h"

@interface BFTextViewCell ()<UITextViewDelegate>

@end

@implementation BFTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{

    self.textView.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B12].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.clipsToBounds = YES;
    self.textView.text = @"请输入菜品简介";
    self.textView.delegate = self;
    
    self.bottomLable.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    self.bottomLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.bottomLable.text = @"选择或修改图片";
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@"请输入菜品简介"] && self.textView.isFirstResponder) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    return YES;
}

//- (void)textViewDidChange:(UITextView *)textView{
//    if ([self.textView.text isEqualToString:@""]) {
//        [self textViewPlacehodel];
//    }
//}


- (void)textViewPlacehodel{
    self.textView.text = @"请输入菜品简介";
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
}

- (void)setTextViewText:(NSString *)textStr{
    self.textView.text = textStr;
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B5];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@""]) {
        self.textView.text = @"请输入菜品简介";
        self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
