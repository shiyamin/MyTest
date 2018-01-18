//
//  BFNewWaiterCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/23.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFNewWaiterCell.h"

@interface BFNewWaiterCell ()<UITextFieldDelegate>

@end

@implementation BFNewWaiterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubviews];
}



- (void)setStatusForSubviews{
    NSArray *tfArr = @[self.phoneNameTf,self.psdTf,self.userNameTf];
    for (UITextField *tf in tfArr) {
        tf.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        tf.textColor = [UIColor colorWithHex:BF_COLOR_B5];
        tf.delegate = self;
    }
    
    NSArray *backViewArr = @[self.phoneBackView,self.psdBackView,self.nameBackView];
    for (UIView *backView in backViewArr) {
        backView.layer.cornerRadius = 5;
        backView.clipsToBounds = YES;
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        backView.backgroundColor = [UIColor whiteColor];
    }
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
}

- (void)configPhoneTf:(NSString *)phoneStr psdTf:(NSString *)psdStr userNameTf:(NSString *)userStr{
    self.phoneNameTf.text =[NSString stringWithFormat:@"%@",phoneStr];
    self.phoneNameTf.userInteractionEnabled = NO;
    self.psdTf.text = psdStr;
    self.userNameTf.text = userStr;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.changeBlo) {
        self.changeBlo();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
