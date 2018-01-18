//
//  BFWithdrawController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWithdrawController.h"
#import "BFWithdrawCell.h"
#import "DKPayKeyView.h"
#import "BFBankCardController.h"
#import "BFQueryServices.h"
#import "BFBankModel.h"
#import "BFSelectMoneyController.h"



@interface BFWithdrawController ()<UITableViewDelegate,UITableViewDataSource,DKPayKeyViewDelegate,BFWithdrawCellDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)DKPayKeyView *payView;

@property (nonatomic, assign) BOOL isFirstShow;

@property (nonatomic, copy) NSString *payKey;

@end

@implementation BFWithdrawController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFWithdrawCell" bundle:nil] forCellReuseIdentifier:BFWithdrawCellIdentifier];
        _tabbleView.tableFooterView = [[UIView alloc] init];
    }
    return _tabbleView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现选择";
    [self setStatusForSubViews];
    self.payView = [[DKPayKeyView alloc] initWithNum:6];
    self.payView.delegate = self;
    [self.view addSubview:self.payView];
    [self.view sendSubviewToBack:self.payView];
    [self checkIsSetPassword];
    [self getBankCardInfoList];
}


- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
}


- (void)checkIsSetPassword{
    [[BFQueryServices alloc] checkIsSetPayPasswordSuccessBlock:^(id result) {
        BOOL isSet = [result boolValue];
        if (isSet) {
            [self getBankCardInfoList];
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


- (void)getBankCardInfoList{
    
    
    [[BFQueryServices alloc] getBankCardListWithSuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        [self.tabbleView reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
    
    
}

- (void)backgroundViewTouched{
    [self.navigationController popViewControllerAnimated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFWithdrawCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArr.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        }
        cell.textLabel.text = @"使用新卡提现";
        cell.textLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
        cell.textLabel.textColor = [UIColor colorWithHex:BF_COLOR_B5];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    BFWithdrawCell *withCell = [tableView dequeueReusableCellWithIdentifier:BFWithdrawCellIdentifier forIndexPath:indexPath];
    withCell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFBankModel *bankModle = self.dataArr[indexPath.row];
    withCell.delegate = self;
    withCell.indexPat = indexPath;
    [withCell configCellWithPersonName:[BFUserSignelton shareBFUserSignelton].truename bankNum:bankModle.number bankName:bankModle.bankName];
    return withCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArr.count) {
        BFBankCardController *bankVc = [[BFBankCardController alloc] init];
        bankVc.withDrawVc = self;
        [self.navigationController pushViewController:bankVc animated:YES];
    }

}

- (void)didSelectWithdrawBtn:(NSIndexPath *)indexPath{
    BFSelectMoneyController *moneyVc = [[BFSelectMoneyController alloc] init];
    moneyVc.shopModel = self.shopModel;
    BFBankModel *bankModle = self.dataArr[indexPath.row];
    moneyVc.bankModel = bankModle;
    [self.navigationController pushViewController:moneyVc animated:YES];
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
