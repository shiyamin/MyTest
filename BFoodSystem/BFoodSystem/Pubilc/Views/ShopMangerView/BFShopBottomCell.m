//
//  BFShopBottomCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopBottomCell.h"

@interface BFShopBottomCell ()<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger foodType;


@end

@implementation BFShopBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configSubviews];
    
    
}
- (NSArray *)dataArr {
    if (!_tagListArr) {
        _tagListArr = [NSArray array];
    }
    return _tagListArr;
}


- (void)configSubviews{
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    self.backGrView.backgroundColor = [UIColor whiteColor];
    self.backGrView.layer.cornerRadius = 5;
    self.backGrView.clipsToBounds = YES;
    self.backGrView.layer.borderWidth = 1;
    self.backGrView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.mealView.layer.cornerRadius = 5;
    self.mealView.clipsToBounds = YES;
    self.mealView.layer.borderWidth = 1;
    self.mealView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mealFreeLabel.tag = 999;
    
    self.tagView.layer.cornerRadius = 5;
    self.tagView.clipsToBounds = YES;
    self.tagView.layer.borderWidth = 1;
    self.tagView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    
    self.tagsmallView.layer.borderWidth = 1;
    self.tagsmallView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.leftBtn setTitle:@"正餐" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"快餐" forState:UIControlStateNormal];
    
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 20)];
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 20)];

    [self.payLeftBtn setTitle:@"先吃后付" forState:UIControlStateNormal];
    [self.payRightBtn setTitle:@"先付后吃" forState:UIControlStateNormal];
    
    [self.payLeftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 20)];
    [self.payRightBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 20)];
    
    [self setLeftBtnStatus:nil];
}


- (void)setLeftBtnStatus:(UIButton *)sender{
    [self.leftBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.rightBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong_not"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.foodType = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnAction:payType:)]) {
        [self.delegate payBtnAction:self.leftBtn payType:@"0"];
    }
}

- (void)setRightBtnStatus:(UIButton *)sender{
    [self.rightBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.leftBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong_not"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnAction:payType:)]) {
        [self.delegate payBtnAction:self.rightBtn payType:@"1"];
    }
}

- (void)configTextView:(NSString *)shopDes mealFee:(NSString *)mealFee tagArr:(NSArray *)tagArr andBtnStauts:(NSString *)type payStatus:(NSString *)payStatus{
    self.textView.text = shopDes;
    if (mealFee.length != 0) {
//        NSArray *meal = [mealFee componentsSeparatedByString:@"."];
        self.mealFreeTF.text = mealFee;
        self.mealFreeTF.delegate = self;
    }else {
        self.mealFreeTF.text = nil;
    }
    self.tagListArr = tagArr;
    if ([[NSString stringWithFormat:@"%@",type] isEqualToString:@"0"]) {
        [self setLeftBtnStatus:nil];
        self.foodType = 0;
    }else{
        [self setRightBtnStatus:nil];
        self.foodType = 1;
    }
    if ([payStatus integerValue] == 0) {
        [self isHiddenFoodWayBtn:YES];
        [self setSelectBtnStatus:self.payLeftBtn nomalBtn:self.payRightBtn];
    }else{
        [self isHiddenFoodWayBtn:NO];
        [self setSelectBtnStatus:self.payRightBtn nomalBtn:self.payLeftBtn];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.mealFreeTF endEditing:YES];
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    [self setLeftBtnStatus:sender];
}


- (IBAction)rightBtnAction:(UIButton *)sender {
    [self setRightBtnStatus:sender];
   
}


- (IBAction)payLeftBtnAction:(UIButton *)sender {
    [self setSelectBtnStatus:sender nomalBtn:self.payRightBtn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnAction:payType:)]) {
        [self.delegate payBtnAction:sender payType:@"0"];
    }
    [self isHiddenFoodWayBtn:YES];

}



- (IBAction)payRightBtnAction:(UIButton *)sender {
    
    [self setSelectBtnStatus:sender nomalBtn:self.payLeftBtn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(payBtnAction:payType:)]) {
        [self.delegate payBtnAction:sender payType:@"1"];
    }
    [self isHiddenFoodWayBtn:NO];
}


- (void)setSelectBtnStatus:(UIButton *)selectBtn nomalBtn:(UIButton *)nomalBtn{
    [selectBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [nomalBtn setImage:[[UIImage imageNamed:@"dm_xuanzhong_not"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

}

- (void)isHiddenFoodWayBtn:(BOOL)hiddenStatus{
    
    if(hiddenStatus){
        [self.rightBtn setImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.leftBtn setImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        self.leftBtn.enabled = NO;
        self.rightBtn.enabled = NO;
        
    }else{
        if (self.foodType == 0) {
            [self setLeftBtnStatus:nil];
        }else{
             [self setRightBtnStatus:nil];
        }
        self.leftBtn.enabled = YES;
        self.rightBtn.enabled = YES;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
