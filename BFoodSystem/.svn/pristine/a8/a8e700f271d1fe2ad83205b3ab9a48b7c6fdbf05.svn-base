//
//  BFWalletController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWalletController.h"
#import "BFWalletHeadView.h"
#import "UIButton+BFRedButton.h"
#import "BFTakeMoneyController.h"
#import "BFQueryBalanceController.h"
#import "BFShopServices.h"
#import "BFShopDetailModel.h"

@interface BFWalletController ()

@property (nonatomic, strong) BFWalletHeadView *headView;
@property (nonatomic, strong) BFShopDetailModel *shopModel;

@end

@implementation BFWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self setStatusForSubViews];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopDetail];

}

- (void)setStatusForSubViews{
    self.headView = [[NSBundle mainBundle] loadNibNamed:@"BFWalletHeadView" owner:nil options:0].lastObject;
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(260);
    }];
    
    UIButton *withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:withdrawBtn];
    [withdrawBtn setButtonRedStatus];
    [withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    withdrawBtn.tag = 1;
    [withdrawBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.headView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:queryBtn];
    [queryBtn setButtonRedStatus];
    [queryBtn setTitle:@"余额明细查询" forState:UIControlStateNormal];
    queryBtn.tag = 2;
    [queryBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(withdrawBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
}


- (void)getShopDetail{
    [[BFShopServices alloc] getShopDetailInfoWithSuccessBlock:^(id result) {
        self.shopModel = (BFShopDetailModel *)result;
        CGFloat rightMoney =  [self.shopModel.merchantModel.amount floatValue] - [self.shopModel.merchantModel.withdraw floatValue];
        [self.headView configTotalMoney:[NSString stringWithFormat:@"%.2f",rightMoney] leftMoney:[NSString stringWithFormat:@"%.2f",rightMoney] rightMoney: self.shopModel.merchantModel.withdraw];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
    
   
}



- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 1) {
        BFTakeMoneyController *drawVc = [[BFTakeMoneyController alloc] init];
        drawVc.shopModel = self.shopModel;
        CGFloat rightMoney =  [self.shopModel.merchantModel.amount floatValue] - [self.shopModel.merchantModel.withdraw floatValue];
        self.shopModel.merchantModel.amount = [NSString stringWithFormat:@"%.2f",rightMoney];
        [self.navigationController pushViewController:drawVc animated:YES];
    }else{
        BFQueryBalanceController *queryVc = [[BFQueryBalanceController alloc] init];
        [self.navigationController pushViewController:queryVc animated:YES];
    }
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
