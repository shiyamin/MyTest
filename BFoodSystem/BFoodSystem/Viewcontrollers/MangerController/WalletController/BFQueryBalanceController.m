//
//  BFQueryBalanceController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryBalanceController.h"
#import "BFQueryBalanceCell.h"
#import "BFQueryServices.h"
#import "BFUserAmountModel.h"
#import "BJNoDataView.h"
#import "UIImageView+ZJFCustomImageView.h"

@interface BFQueryBalanceController ()<BFDataSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *showImageView;

@end

@implementation BFQueryBalanceController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额明细查询";
    
}


- (void)addSubviews{
    self.dataView.delegate = self;
    [self.view addSubview:self.tabbleView];
    self.tabbleView.showsVerticalScrollIndicator = NO;
    self.tabbleView.showsHorizontalScrollIndicator = NO;
    [self.dataView hiddenTipsLableAndImage];
    
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFQueryBalanceCell" bundle:nil] forCellReuseIdentifier:BFQueryBalanceCellIdentifier];
    
}

-(void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr{
    BFLog(@"%@====%@", beginStr,endStr);
    [BFUtils showProgressHUDWithTitle:@"查询中..." inView:self.view animated:YES];
    [[BFQueryServices alloc] getUserAccountWithStratTime:beginStr endTimeStr:endStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        self.dataArr = (NSMutableArray *)result;
        if ([self.dataArr isKindOfClass:[NSMutableArray class]] && self.dataArr.count == 0) {
            _showImageView = [UIImageView showNonDateImageWithAddView:self.tabbleView];
            [_showImageView removeFromSuperview];
            [self.tabbleView addSubview:_showImageView];
        } else if (self.dataArr.count > 0) {
            [_showImageView removeFromSuperview];
            
        }
        [self.tabbleView  reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFQueryBalanceCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFQueryBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:BFQueryBalanceCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell setBackgroundIamge:@"cx_t"];
    }else{
        [cell setBackgroundIamge:@"cx_d"];
    }
    BFUserAmountModel *accountModel = self.dataArr[indexPath.row];
    [cell configTtile:accountModel.create_date detailLableText:accountModel.remark andPayProfitMoney:accountModel.fee];
    
    return cell;
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
