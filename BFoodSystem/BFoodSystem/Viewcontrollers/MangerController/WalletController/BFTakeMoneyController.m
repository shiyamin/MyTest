//
//  BFTakeMoneyController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/6/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTakeMoneyController.h"
#import "BFTakeMoneyHeadView.h"
#import "BFTakeMoneyCell.h"
#import "BFProfitModel.h"
#import "BFQueryServices.h"
#import "DKPayKeyView.h"


@interface BFTakeMoneyController ()<UITableViewDelegate,UITableViewDataSource,DKPayKeyViewDelegate>

@property (nonatomic, strong) UITableView *tabbleView;
@property (nonatomic, strong) BFTakeMoneyHeadView *headView;

@property (nonatomic, strong)DKPayKeyView *payView;

@property (nonatomic, assign) BOOL isFirstShow;

@property (nonatomic, assign) BOOL isSubmit;

@property (nonatomic, copy) NSString *payKey;

@property (nonatomic, strong) BFProfitModel *payModel;

@end

@implementation BFTakeMoneyController

-(UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        _tabbleView.backgroundColor =[UIColor colorWithHex:BF_COLOR_B1];
        _tabbleView.separatorColor = [UIColor clearColor];
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFTakeMoneyCell" bundle:nil] forCellReuseIdentifier:BFTakeMoneyCellIdentifier];
    }
    return _tabbleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    self.isSubmit = NO;
    [self configStatus];
    [self setStatusForSubViews];
    [self checkIsSetPassword];
}

- (void)configStatus{
    for (int count = 0; count < self.shopModel.profitArr.count; count ++) {
        BFProfitModel *model = self.shopModel.profitArr[count];
        if (count == 0) {
            model.selectStatus = @"yes";
            self.payModel = model;
        }else{
            model.selectStatus = @"no";
        }
    }
}

- (void)checkIsSetPassword{
    [[BFQueryServices alloc] checkIsSetPayPasswordSuccessBlock:^(id result) {
        BOOL isSet = [result boolValue];
        if (isSet) {
            
        }else{
            self.isFirstShow = YES;
            [self.payView configTitleLable:@"请设置支付密码"];
            [self.view bringSubviewToFront:self.payView];
        }
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (void)submitBtnActionWithText:(NSString *)text{
    
    if (self.isFirstShow) {
        if ([text isEqualToString:@""]) {
            return;
        }
        [self.payView configTitleLable:@"请再输入一次"];
        [self.payView setViewToDefault];
        self.payKey = text;
        self.isFirstShow = NO;
    }else if (self.isSubmit){
        [[BFQueryServices alloc] verifyPayPasswordWith:text SuccessBlock:^(id result) {
            NSDictionary *res = (NSDictionary *)result;
            BOOL isOk = [[res objectForKey:@"isOK"] boolValue];
            if (isOk) {
                [self withdrawRequst:text];
                [self.view sendSubviewToBack:self.payView];
            }else{
                [self.payView setViewToDefault];
                [self.payView configTitleLable:@"密码输入有误，请重新输入"];
            }
            
        }  errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
            
        } Failure:^(NSError *error) {
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
            
        }];

    }else{
        
        if ([text isEqualToString:self.payKey]) {
            
            [self.view sendSubviewToBack:self.payView];
            
            [[BFQueryServices alloc] setPayPasswordWtihNewPassword:text oldPass:@"" SuccessBlock:^(id result) {
                [BFUtils showAlertController:0 title:@"" message:@"支付密码设置成功"];
                
            } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                [BFUtils showAlertController:0 title:@"" message:errorMessage];
                
            } Failure:^(NSError *error) {
                [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
            }];
            
        }else{
            [self.payView configTitleLable:@"两次密码不一致，请重新输入"];
            [self.payView setViewToDefault];
        }
    }
}

- (void)backgroundViewTouched{
    [self.payView payViewHiddenKeyboard];
    if (self.isSubmit) {
        [self.view sendSubviewToBack:self.payView];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    self.headView = [[BFTakeMoneyHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    BFProfitModel *proModel = self.shopModel.profitArr.firstObject;
    [self.headView configBankName:self.shopModel.merchantModel.bank bankNum:self.shopModel.merchantModel.bankCard totalMoney:self.shopModel.merchantModel.amount profit:proModel.rate];
    [self.tabbleView setTableHeaderView:self.headView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    footView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self.tabbleView setTableFooterView:footView];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(12);
        make.right.equalTo(footView).offset(-12);
        make.bottom.equalTo(footView.mas_bottom).offset(-20);
        make.height.mas_equalTo(40);
    }];

    [submitBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.clipsToBounds = YES;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [submitBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.payView = [[DKPayKeyView alloc] initWithNum:6];
    self.payView.delegate = self;
    [self.view addSubview:self.payView];
    [self.view sendSubviewToBack:self.payView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sessionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    sessionHead.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    titleLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    titleLab.text = @"   到账方式";
    [sessionHead addSubview:titleLab];
    [sessionHead borderForColor:[UIColor colorWithHex:BF_COLOR_B1] borderWidth:1.0 borderType:UIBorderSideTypeBottom];
    return sessionHead;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopModel.profitArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFTakeMoneyCellheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFTakeMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:BFTakeMoneyCellIdentifier forIndexPath:indexPath];
    BFProfitModel *model = self.shopModel.profitArr[indexPath.row];
    [cell configTitle:model.name detail:model.remark];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    if ([model.selectStatus isEqualToString:@"yes"]) {
        [cell setCellSelectStatus:YES];
    }else{
        [cell setCellSelectStatus:NO];
    }
    [cell borderForColor:[UIColor colorWithHex:BF_COLOR_B1] borderWidth:1 borderType:UIBorderSideTypeBottom];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFProfitModel *model = self.shopModel.profitArr[indexPath.row];
    for (int count = 0; count < self.shopModel.profitArr.count; count ++) {
        BFProfitModel *model = self.shopModel.profitArr[count];
        if (count == indexPath.row) {
            model.selectStatus = @"yes";
            self.payModel = model;
        }else{
            model.selectStatus = @"no";
        }
    }
    [self.tabbleView reloadData];
    [self.headView changeProfit:model.rate];
}

- (void)submitAction{
    [self.view endEditing:YES];
    if ([self.headView.moneyTF.text floatValue] < 0) {
         [BFUtils showAlertController:0 title:@"" message:@"余额不足"];
        return ;
    }
    CGFloat profitMoney = [self.headView.moneyTF.text floatValue] * [self.payModel.rate floatValue];
    if (profitMoney < 0.1) {
        profitMoney = 0.1;
    }
    CGFloat totalMoney = [self.shopModel.merchantModel.amount floatValue] - profitMoney;
    if ([self.headView.moneyTF.text floatValue] > totalMoney) {
        NSString *message = [NSString stringWithFormat:@"剩余零钱不足以支付提现手续￥%.2f，当前最大可提现金额为￥%.2f \n\n是否要全部提现？",profitMoney,totalMoney];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"全部提现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.headView.moneyTF.text = [NSString stringWithFormat:@"%.2f",totalMoney];
            self.headView.promptLab.text = [NSString stringWithFormat:@"额外扣除%.2f手续费",profitMoney];

            [self submitShowPayView];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alertVc addAction:okAction];
        [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    }else{
        [self submitShowPayView];
    }
    


}

- (void)submitShowPayView{
    [self.payView setViewToDefault];
    [self.payView configTitleLable:@"请输入支付密码"];
    self.isSubmit = YES;
    [self.view bringSubviewToFront:self.payView];
    [self.payView payViewShowKeyboard];
}

- (void)withdrawRequst:(NSString *)psdStr{
    
    [[BFQueryServices alloc] withdrawMoneyWithPassword:psdStr withAmount:self.headView.moneyTF.text payModel:self.payModel.mode SuccessBlock:^(id result) {
//        [self.navigationController popViewControllerAnimated:YES];
        self.shopModel.merchantModel.amount = [NSString stringWithFormat:@"%.2f",[self.shopModel.merchantModel.amount floatValue] - [self.headView.moneyTF.text floatValue]];
        self.headView.moneyTF.placeholder = [NSString stringWithFormat:@"可提现金额%@元",self.shopModel.merchantModel.amount];
        [BFUtils showAlertController:0 title:@"" message:@"提现申请发送成功"];
    }  errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:1 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
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
