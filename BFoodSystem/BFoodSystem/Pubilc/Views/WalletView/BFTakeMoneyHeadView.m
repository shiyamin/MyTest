//
//  BFTakeMoneyHeadView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/6/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTakeMoneyHeadView.h"

@interface BFTakeMoneyHeadView () <UITextFieldDelegate>

@property (nonatomic, strong)UILabel *bankLable;

@property (nonatomic, copy) NSString *totalMoney;
@property (nonatomic, assign)CGFloat profitStr;

@property (nonatomic, assign) BOOL isAllAction;

@end

@implementation BFTakeMoneyHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *bankIcon = [[UIImageView alloc] init];
    [bankIcon setImage:[UIImage imageNamed:@"yinhang"]];
    [self addSubview:bankIcon];
    [bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    
    self.bankLable = [[UILabel alloc] init];
    self.bankLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    self.bankLable.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    self.bankLable.text = @"广州农商银行(9431)";
    [self addSubview:self.bankLable];
    [self.bankLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bankIcon.mas_right).offset(2);
        make.top.equalTo(lineView.mas_bottom);
        make.right.equalTo(self).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lableBotLine = [[UIView alloc] init];
    lableBotLine.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self addSubview:lableBotLine];
    [lableBotLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.bankLable.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *moneyIcon = [[UIImageView alloc] init];
    [moneyIcon setImage:[UIImage imageNamed:@"qian"]];
    [self addSubview:moneyIcon];
    [moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(lableBotLine.mas_bottom).offset(30);
        make.width.height.mas_equalTo(20);
    }];
    
    self.moneyTF = [[UITextField alloc] init];
    [self addSubview:self.moneyTF];
    self.moneyTF.font = [UIFont systemFontOfSize:BF_FONTSIZE_a5];
    self.moneyTF.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    self.moneyTF.placeholder = @"可提现金额";
    self.moneyTF.delegate = self;
    self.moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    [self.moneyTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyIcon.mas_right).offset(5);
        make.top.equalTo(lableBotLine.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    UIView *tfBotLine = [[UIView alloc] init];
    tfBotLine.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self addSubview:tfBotLine];
    [tfBotLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.moneyTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"全部提出" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHex:BF_COLOR_B10] forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [allBtn addTarget:self action:@selector(allBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyTF.mas_right).offset(2);
        make.top.height.equalTo(self.moneyTF);
        make.width.mas_equalTo(60);
        make.right.equalTo(self).offset(-10);
    }];
    
    self.promptLab = [[UILabel alloc] init];
    self.promptLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.promptLab.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    [self addSubview:self.promptLab];
    [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(allBtn.mas_bottom).offset(2);
        make.right.equalTo(self).offset(-12);
        make.height.mas_equalTo(30);
    }];
    
    
}

- (void)configBankName:(NSString *)bankName bankNum:(NSString *)bankNum totalMoney:(NSString *)totalMoney profit:(NSString *)profit{
    self.moneyTF.placeholder = [NSString stringWithFormat:@"可提现金额%@元",totalMoney];
    bankNum = StringValue(bankNum);
    NSString *num = [bankNum substringWithRange:NSMakeRange(bankNum.length -4, 4)];
    self.bankLable.text = [NSString stringWithFormat:@"%@(%@)",StringValue(bankName),num];
    self.profitStr = [profit floatValue];
    self.totalMoney = totalMoney;
}


- (void)changeProfit:(NSString *)profit{
    [self hiddenKeyboard];
    CGFloat totalMoney = [self getCanWithDrawMoney];
    if (self.moneyTF.text  == [NSString stringWithFormat:@"%.2f",totalMoney]) {
        
        CGFloat profitMoney = [self.totalMoney floatValue] * [profit floatValue];
        if (profitMoney < 0.1) {
            profitMoney = 0.1;
        }
        self.promptLab.text = [NSString stringWithFormat:@"额外扣除%.2f手续费",profitMoney];
        CGFloat allMoney = [self.totalMoney floatValue] - profitMoney;
        self.moneyTF.text = [NSString stringWithFormat:@"%.2f",allMoney];
    }else{
        CGFloat profitMoney = [self.moneyTF.text floatValue] * [profit floatValue];
        if (profitMoney < 0.1) {
            profitMoney = 0.1;
        }
        self.promptLab.text = [NSString stringWithFormat:@"额外扣除%.2f手续费",profitMoney];
    }
    self.profitStr = [profit floatValue];

}

- (void)hiddenKeyboard{
    [self.moneyTF resignFirstResponder];
}

- (void)allBtnAction{
    [self hiddenKeyboard];
    self.isAllAction = YES;
    self.moneyTF.text = [NSString stringWithFormat:@"%.2f",[self.totalMoney floatValue]];
    CGFloat totalMoney = [self getCanWithDrawMoney];
    self.moneyTF.text = [NSString stringWithFormat:@"%.2f",totalMoney];
    self.promptLab.text = [NSString stringWithFormat:@"额外扣除%.2f手续费",[self getProfitMoney]];

}

- (void)textChange:(UITextField *)textTf{
    
    CGFloat withDrawMoney = [textTf.text floatValue];
    CGFloat totalMoney = [self getCanWithDrawMoney];
    if (withDrawMoney>totalMoney) {
        self.promptLab.text = @"您的可用提现金额不足";
    }else{
        self.promptLab.text = [NSString stringWithFormat:@"额外扣除%.2f手续费",[self getProfitMoney]];
    }
}

- (CGFloat )getCanWithDrawMoney{

    return [self.totalMoney floatValue] - [self getProfitMoney];

}

- (CGFloat)getProfitMoney{
    CGFloat profitMoney = [self.moneyTF.text floatValue] * self.profitStr;
    if (profitMoney < 0.1) {
        profitMoney = 0.1;
    }
    return profitMoney;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.isAllAction = NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *money = textField.text;
    if ([money containsString:@"."] && [string isEqualToString:@"."]) {
        return NO;
    }
    if ([money containsString:@"."]) {
        NSArray *charArr = [money componentsSeparatedByString:@"."];
        NSString *lasStr = charArr.lastObject;
        if (lasStr.length == 2 && ![string isEqualToString:@""]) {
            return NO;
        }
    }

    return YES;
}


@end





