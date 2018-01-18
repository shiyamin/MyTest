//
//  DKPayKeyView.m
//  bombDemo
//
//  Created by 名正 on 15/10/13.
//  Copyright © 2015年 名正 All rights reserved.
//

#import "DKPayKeyView.h"
#import "UIColor+Hex.h"


@interface DKPayKeyView () <UITextFieldDelegate>

@property (nonatomic, strong)UITextField *texfiled;
@property (nonatomic, strong)NSMutableArray *textArray;
@property (nonatomic, assign)NSInteger  integer;

@property (nonatomic, strong) UILabel *titleLable;

@end


@implementation DKPayKeyView

- (instancetype)initWithNum:(NSInteger )integer{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.integer = integer;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    

   self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    UIView *payBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 140)];
    CGPoint center = self.center;
    center.y = self.center.y - 100;
    payBackView.center = center;
    payBackView.backgroundColor = [UIColor whiteColor];
    payBackView.layer.cornerRadius = 10;
    payBackView.clipsToBounds = YES;
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTouch)];
    [self addGestureRecognizer:touch];
    [self addSubview:payBackView];
    
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, payBackView.frame.size.width, 30)];
    self.titleLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.titleLable.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.text = @"请输入支付密码";
    [payBackView addSubview:self.titleLable];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(16, 52, 247, 42)];
    textFiled.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    textFiled.borderStyle = UITextBorderStyleNone;
    textFiled.secureTextEntry = YES;
    textFiled.tintColor = [UIColor clearColor];
    textFiled.textColor = [UIColor clearColor];
    textFiled.keyboardType = UIKeyboardTypeNumberPad;
    textFiled.delegate = self;
    [textFiled addTarget:self action:@selector(passcodeChanged:) forControlEvents:UIControlEventEditingChanged];
    self.texfiled = textFiled;
    [payBackView addSubview:textFiled];
    
    
    NSMutableArray *textArr =  [NSMutableArray array];
    NSInteger count = self.integer;
    CGFloat winth = 40;
    for (int i = 0; i < count; i++) {
        UILabel *textFiledLable = [[UILabel alloc] initWithFrame:CGRectMake(20 + i *(winth - 0.5), 52, winth, winth)];
        [payBackView addSubview:textFiledLable];
        textFiledLable.layer.borderWidth = 0.5;
        textFiledLable.layer.borderColor = [UIColor colorWithHex:@"969696"].CGColor;
        textFiledLable.tintColor = [UIColor blackColor];
        textFiledLable.textAlignment = NSTextAlignmentCenter;
        textFiledLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a5];
        [textArr addObject:textFiledLable];
    }
    self.textArray = textArr;
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setBackgroundColor:[UIColor colorWithHex:@"d3b17d"]];
    [okBtn setFrame:CGRectMake(0, 100, 280, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [okBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [payBackView addSubview:okBtn];
}

- (void)configTitleLable:(NSString *)title{
    self.titleLable.text = title;
  
}


- (void)payViewShowKeyboard{
    [self.texfiled becomeFirstResponder];
}


- (void)payViewHiddenKeyboard{
    [self.texfiled resignFirstResponder];
}

- (void)backgroundViewTouch{
    if ([self.delegate respondsToSelector:@selector(backgroundViewTouched)]) {
        [self.delegate backgroundViewTouched];
    }
}

- (void)setViewToDefault{
    self.texfiled.text = @"";
    for (NSInteger index = 0; index<self.textArray.count; index ++) {
        UILabel *lab = self.textArray[index];
        lab.text = @"";
    }
}

- (void)btnAction:(UIButton *)sender{
    [self.texfiled resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(submitBtnActionWithText:)]) {
        [self.delegate submitBtnActionWithText:self.texfiled.text];
    }
}


- (void)passcodeChanged:(UITextField *)sender{
    
    NSInteger count  = [sender.text length];
    if (count >6) {
        sender.text = [sender.text substringToIndex:6];
        return;
    }
    for (NSInteger index = 0; index<self.textArray.count; index ++) {
        UILabel *lab = self.textArray[index];
        if (index < count) {
            lab.text = @"•";
        }else{
            lab.text = @"";
        }
    }
}







@end
