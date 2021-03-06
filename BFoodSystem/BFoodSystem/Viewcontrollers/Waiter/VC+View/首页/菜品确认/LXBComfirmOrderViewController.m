//
//  LXBComfirmOrderViewController.m
//  01 点餐页面
//
//  Created by binbin on 2017/4/14.
//  Copyright © 2017年 XM. All rights reserved.
//

#import "LXBComfirmOrderViewController.h"

#import "UIButton+BFRedButton.h"
#import "BFOrderServices.h"
#import "ZJFConfirmListModel.h"
#import "BFOrderServices.h"
#import "LXBComfirmOrderTableView.h"
#import "ZJFFoodConfirmModel.h"


@interface LXBComfirmOrderViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) LXBComfirmOrderTableView *tbView;

@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *messageID;
@property (nonatomic, copy) NSString *desk_name;
@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, copy) NSString *remarkStr;

@property (nonatomic, copy) NSString *orderSn;


@end

@implementation LXBComfirmOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"菜品的确认";
    [self getData];
    [self createSubViews];
    [self.view addSubview:self.tbView];
    self.view.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];

}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [BFUserSignelton shareBFUserSignelton].isPushConfirmVc = NO;

}

- (void)getData {
    
    NSDictionary *extras = [self.notificationDic valueForKey:@"extras"];
    if (extras != nil || extras != NULL) {
        _orderID = [extras objectForKey:@"order_id"];
        _userID = [extras objectForKey:@"user_id"];
        _messageID = [extras objectForKey:@"msg_id"];
        _desk_name = [extras objectForKey:@"desk_name"];
        _area_name = [extras objectForKey:@"area_name"];
        
    } else if (self.listModel.data != nil) {

        _orderID = [self.listModel.data objectForKey:@"order_id"];
        _userID = [self.listModel.data objectForKey:@"user_id"];
        _messageID = self.listModel.messageId;
        _desk_name = [self.listModel.data objectForKey:@"desk_name"];
        _area_name = [self.listModel.data objectForKey:@"area_name"];
        
    }
    
    BFLog(@"oderID--------=%@", self.orderID);
    [[BFOrderServices alloc] orderListWithOrderId:self.orderID userId:self.userID SuccessBlock:^(id result) {
        NSMutableArray *modelArr = (NSMutableArray *)result;
        ZJFFoodConfirmModel *model = [modelArr firstObject];
        self.tbView.dataListArr = model.dishesArr;
        self.tbView.dining_number = model.number;
        self.tbView.payStatus = model.status;
        self.tbView.desk_name = self.desk_name;
        self.tbView.area_name = self.area_name;
        self.orderSn = model.orderSn;

        [self.tbView configUI];
        [self.tbView reloadData];

        self.remarkStr = model.remark;
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
    
    
}
- (void)passOrderRequestWithOrderId{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd-HH:mm"];
    NSString *time = [format stringFromDate:nowDate];
    NSMutableArray *foodArr = [NSMutableArray array];
    for (ZJFConfirmListModel *model  in self.tbView.dataListArr) {
        NSDictionary *foodDic = @{@"Name":model.name,@"Seat":[NSString stringWithFormat:@"%ld",[model.quantity integerValue]]};
        [foodArr addObject:foodDic];
    }
    NSDictionary *foodDic = @{@"Name":@"餐位",@"Seat":[NSString stringWithFormat:@"%@",self.tbView.dining_number]};
    [foodArr addObject:foodDic];
    
    [[BFOrderServices alloc] passMenuWithTableNum:self.desk_name printIp:[BFUserSignelton shareBFUserSignelton].printer_addr time:time orderNum:self.orderSn passOrderArr:foodArr remark:StringValue(self.remarkStr) SuccessBlock:^(id result) {
        [BFUtils showAlertController:0 title:@"" message:@"订单已送至厨房"];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
}

- (LXBComfirmOrderTableView *)tbView
{
    if (_tbView == nil) {
        CGFloat tbHeight = SCREEN_HEIGHT - 286;
        _tbView = [[LXBComfirmOrderTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tbHeight) style:UITableViewStylePlain];
        
    }
    return _tbView;
}

- (void)createSubViews
{
    //拒绝
    UIButton *refuseBut = [UIButton configUniversalWithTitle:@"拒绝" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B0 withBgImage:nil withBgColor:BF_COLOR_L23];
    [refuseBut setButtonRedStatus];
    refuseBut.backgroundColor = [UIColor redColor];
    refuseBut.tag = 999;
    [self.view addSubview:refuseBut];
    [refuseBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
    }];
    [refuseBut addTarget:self action:@selector(confrimAndRefuseAction:) forControlEvents:UIControlEventTouchUpInside];
    //确认
    UIButton *confrimBut  = [UIButton configUniversalWithTitle:@"确认" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B0 withBgImage:nil withBgColor:BF_COLOR_B10];
    [confrimBut setButtonRedStatus];
    
    [self.view addSubview:confrimBut];
    [confrimBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(refuseBut.mas_top).with.offset(-10);
    }];
    [confrimBut addTarget:self action:@selector(confrimAndRefuseAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 拒绝 / 确定

- (void)confrimAndRefuseAction:(UIButton *)sender
{
    NSString *alertMessage;
    NSString *foodStatus;
    
    if (sender.tag == 999) {
        alertMessage = @"是否拒绝?";
        foodStatus = @"0";
    } else {
        alertMessage = @"是否确认?";
        foodStatus = @"2";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        [[BFOrderServices alloc] confirmWithMessageId: self.messageID status:foodStatus SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUserSignelton shareBFUserSignelton].isPushConfirmVc = NO;
            [BFUtils alertController:nil message:@"信息发送成功"];
            if (sender.tag != 999) {
               [self passOrderRequestWithOrderId];
            }
            
            if (![self.presentedViewController isBeingDismissed]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:updateWaiterDeskNotification object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
            if (![self.presentedViewController isBeingDismissed]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            [BFUserSignelton shareBFUserSignelton].isPushConfirmVc = NO;

            
        } Failure:^(NSError *error) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
            
        }];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了取消按钮");
    }]];
  }

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1 || buttonIndex == 0) {//确定则注销
        //注销操作的代码
        [self.navigationController popToRootViewControllerAnimated:YES];
        [BFUserSignelton shareBFUserSignelton].isPushConfirmVc = NO;

    }
}



@end
