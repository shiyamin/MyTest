//
//  LXBDidOrderViewController.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "LXBDidOrderViewController.h"
#import "LXBDidOrderTbView.h"
#import "BFOrderServices.h"
#import "LXBAlertView.h"
#import "LXBCookingdetailModel.h"
#import "BFDeskModel.h"
#import "LXBOrder_listModel.h"
#import "BFDeskAreaServices.h"

@interface LXBDidOrderViewController ()<alertCartDeleteDelegtae,LXBAlertViewDelegate>
@property (nonatomic, strong) LXBDidOrderTbView *tbView;
@property (nonatomic, strong) NSMutableArray *orderDataArr;
@property (nonatomic, strong) NSMutableArray *revokeDataArr;
@end

@implementation LXBDidOrderViewController
- (void)dealloc
{
//    NSLog(@"%s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已下单";
    [self.view addSubview:self.tbView];

//	self.tbView.dataArr = self.dataArr;

}
#pragma mark - 懒加载
- (NSMutableArray *)orderDataArr
{
    if (_orderDataArr == nil) {
        _orderDataArr = [NSMutableArray array];
    }
    return _orderDataArr;
}

- (NSMutableArray *)revokeDataArr
{
    if (_revokeDataArr == nil) {
        _revokeDataArr = [NSMutableArray array];
    }
    return _revokeDataArr;
}
- (UITableView *)tbView
{
    if (_tbView == nil) {
        _tbView = [[LXBDidOrderTbView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tbView.aletDelegate = self;
    }
    return _tbView;
}
#pragma mark - 数据赋值
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.orderDataArr removeAllObjects];
    [self.revokeDataArr removeAllObjects];
    
    for (BFDeskModel *model in dataArr) {
        for (LXBOrder_listModel *orderModel in model.order_list) {
            NSArray *dishesArr = orderModel.dishes_list;
            NSArray *cancleArr = orderModel.cancel_list;
            for (LXBCookingdetailModel *Cookmodel in dishesArr) {
                [self.orderDataArr addObject:Cookmodel];
            }
            for (LXBCookingdetailModel *Cookmodel in cancleArr) {
                [self.revokeDataArr addObject:Cookmodel];
            }
        }
    }
    self.tbView.orderDataArr = self.orderDataArr;
    self.tbView.revokeDataArr = self.revokeDataArr;
}
#pragma mark - 删除订单菜品的代理方法
- (void)clickCartDelegateAction:(NSString *)deskId
{
    //显示提示框
    LXBAlertView * alert = [[LXBAlertView alloc]initWithView:self.view];
    alert.titleColor = [UIColor orangeColor];
    alert.customValue = deskId;
    [alert showWithTitle:@"撤销备注"
                Delegate:self
      MessageButtonTitle:@[@"菜点错或点多了",@"厨房没有原料",@"厨房上菜太慢",@"其他"]
       cancelButtonTitle:@"取消"
    determineButtonTitle:@"确定"];
}
#pragma mark - 弹框的代理方法;
-(void)lxb_AlertView:(LXBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex RemarkText:(NSString *)remarkText{
    if (buttonIndex == 1) {
        //确定
        //        重新请求数据
        NSArray * array = [self.orderDataArr copy];
        NSString *cusStr = [NSString stringWithFormat:@"%@",alertView.customValue];
        for (LXBCookingdetailModel * model in array) {
            NSString *deskIDStr = [NSString stringWithFormat:@"%@",model.dishesID];
            if ([deskIDStr isEqualToString:cusStr]) {
                [self.orderDataArr removeObject:model];
            }
        }
        [self.tbView reloadData];
        //如果quantity  == 1 需要上传到服务器
        //如果 quantity == 2 不需要上传到服务器
        //上报到服务器
        
        [[BFDeskAreaServices alloc] revokedDishesReportWithParameter:@{@"id":alertView.customValue,@"token":[BFUserSignelton shareBFUserSignelton].token,@"remark":remarkText} SuccessBlock:^(id result) {
            //成
//            if (self.orderDataArr) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"LXBCancelFoodNotification" object:nil];
//            } else {
//                [self.navigationController popViewControllerAnimated:YES];
//            }
           
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            
        } Failure:^(NSError *error) {
            
        }];
    }
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
