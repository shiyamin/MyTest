//
//  BFSelectMoneyController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/5.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFSelectMoneyController.h"
#import "UIButton+BFRedButton.h"
#import "BFQueryServices.h"
#import "DKPayKeyView.h"

@interface BFSelectMoneyController ()<DKPayKeyViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;

@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

@property (weak, nonatomic) IBOutlet UITextField *moneyTexfiled;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong,nonatomic) DKPayKeyView *payKeyView;

@end




@implementation BFSelectMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    
    [self setStatusForSubViews];
}


- (void)setStatusForSubViews{
    self.bankNameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.bankNameLab.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.bankNameLab.text = [NSString stringWithFormat:@"到账银行:%@",self.bankModel.bankName];
    
    self.moneyLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.moneyLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.moneyLable.text = [NSString stringWithFormat:@"可提现金额:%.2f",[self.shopModel.merchantModel.amount floatValue] - [self.shopModel.merchantModel.withdraw floatValue]];
    
    self.moneyTexfiled.layer.cornerRadius = 5;
    self.moneyTexfiled.clipsToBounds = YES;
    self.moneyTexfiled.layer.borderColor = [UIColor grayColor].CGColor;
    self.moneyTexfiled.layer.borderWidth = 1;
    
    [self.submitBtn setButtonRedStatus];
    
    self.payKeyView = [[DKPayKeyView alloc] initWithNum:6];
    self.payKeyView.delegate = self;
    
    
}


- (IBAction)submitBtnAction:(id)sender {
    
    CGFloat totalMoney =[self.shopModel.merchantModel.amount floatValue] - [self.shopModel.merchantModel.withdraw floatValue];
    
    if ([self.moneyTexfiled.text floatValue] <= 0) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入有效金额"];
        return;
    }
    
    if (totalMoney - [self.moneyTexfiled.text floatValue] < 0) {
        [BFUtils showAlertController:0 title:@"" message:@"可提现余额不足"];
        return;
    }
    [self.moneyTexfiled resignFirstResponder];
    [self.view addSubview:self.payKeyView];
    [self.payKeyView setViewToDefault];
    [self.payKeyView configTitleLable:@"请输入支付密码"];

    
    
}

- (void)submitBtnActionWithText:(NSString *)text{
    
    [[BFQueryServices alloc] verifyPayPasswordWith:text SuccessBlock:^(id result) {
        NSDictionary *res = (NSDictionary *)result;
        BOOL isOk = [[res objectForKey:@"isOK"] boolValue];
        if (isOk) {
            [self withdrawRequst:text];
            [self.payKeyView removeFromSuperview];
        }else{
            [self.payKeyView setViewToDefault];
            [self.payKeyView configTitleLable:@"密码输入有误，请重新输入"];
        }
        
    }  errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (void)backgroundViewTouched{
    [self.payKeyView removeFromSuperview];
}


- (void)withdrawRequst:(NSString *)psdStr{
    
    [[BFQueryServices alloc] withdrawMoneyWithPassword:psdStr withAmount:self.moneyTexfiled.text payModel:@"1" SuccessBlock:^(id result) {
        [self.navigationController popViewControllerAnimated:YES];
        [BFUtils showAlertController:0 title:@"" message:@"提现申请发送成功"];
    }  errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}


- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
