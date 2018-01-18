//
//  LXBsubtotalViewController.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "LXBsubtotalViewController.h"
#import "LXBOrder_listModel.h"
#import "LXBCookingdetailModel.h"
#import "BFDeskModel.h"
#import "UIButton+BFRedButton.h"
#import "BFPaymentWayController.h"
#import "BFDingInfoView.h"
#import "BFSubTableView.h"
#import "BFOrderServices.h"
#define KSpace 15
#define KMargin 10
#define KhederViewH 70
#define KDingInfoViewH 90
#define KOrderButtonH 40
@interface LXBsubtotalViewController ()
{
    NSInteger index;
}

@property (nonatomic, strong) BFSubTableView *lxbTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *headerTitleLab;
@property (nonatomic, strong) BFDingInfoView *dingInfoView;
@property (nonatomic, strong) UIButton *affirmOrderButton;

@property (nonatomic, copy) NSMutableDictionary *mDic;
@end

@implementation LXBsubtotalViewController


// 根据颜色得到图片 建议一个方法放在工具类中
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}



- (NSMutableDictionary *)mDic
{
	if (_mDic == nil) {
		_mDic = [NSMutableDictionary dictionary];
	}
	return _mDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费小计";
    [self configUI];
}
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.mDic setDictionary:self.messageDic];
    for (BFDeskModel *model in dataArr) {
        for (LXBOrder_listModel *orderMolde in model.order_list) {
            index  = orderMolde.dishes_list.count + orderMolde.cancel_list.count;
        }
        LXBOrder_listModel *oderModel = [model.order_list lastObject];
        NSString *create_data = model.create_date;
        [self.mDic setValue:create_data forKey:@"create_date"];
        [self.mDic setValue:model.type forKey:@"type"];
        [self.mDic setValue:model.name forKey:@"deskName"];
        [self.mDic setValue:model.number forKey:@"number"];
        [self.mDic setValue:oderModel.orderSn forKey:@"orderSn"];
        [self.mDic setValue:oderModel.remark forKey:@"remark"];

   }
    BFDeskModel *deskModel = [_dataArr lastObject];
    LXBCookingdetailModel *cookingModel = [[LXBCookingdetailModel alloc] init];
    cookingModel.name = @"餐位费";
    NSInteger tableware = [deskModel.tableware integerValue];
    CGFloat tableFee = [deskModel.tableFee floatValue];
    if (tableFee == 0 || tableware == 0) {
        cookingModel.price = [NSString stringWithFormat:@"0.0"];
    }else {
        
        CGFloat price = tableFee / tableware;
        cookingModel.price = [NSString stringWithFormat:@"%.2f",price];
    }
    cookingModel.quantity = [NSString stringWithFormat:@"%@",deskModel.tableware];
    self.lxbTableView.cookingModel = cookingModel;
    self.lxbTableView.dataArr = deskModel.order_list;
    self.lxbTableView.goodsAmount = [deskModel.payWait floatValue];
    
    
    [self configUISetValue];
}

#pragma mark - 创建子视图
- (void)configUI
{
    //创建头部的视图
    [self.view addSubview:self.headerView];
    
    //显示餐桌信息
    [self.view addSubview:self.dingInfoView];
    
    
    //头部视图的创建
    _lxbTableView.backgroundColor = [UIColor clearColor];
    _lxbTableView.opaque = NO;

    [self.affirmOrderButton setTitle:@"确认订单" forState:UIControlStateNormal];
    
    [self.affirmOrderButton addTarget:self action:@selector(makeSuerAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 2) {
        self.affirmOrderButton.hidden = YES;
    }
    
    
}

- (void)printOrderRequest{

    return ;
    BFDeskModel *deskModel = [_dataArr lastObject];
    NSMutableArray *foodArr = [NSMutableArray array];
    for (LXBOrder_listModel *orderModel in deskModel.order_list) {
        NSArray *dishesArr = orderModel.dishes_list;
        for (LXBCookingdetailModel *Cookmodel in dishesArr) {
            CGFloat total = [Cookmodel.quantity integerValue] * [Cookmodel.price floatValue];
            NSDictionary *foodDic = @{@"Name":Cookmodel.name,@"Price":Cookmodel.price,@"Number":Cookmodel.quantity,@"Sum":[NSString stringWithFormat:@"%.2f",total]};
            [foodArr addObject:foodDic];
        }
        

    }
    if (deskModel.tableware) {
        LXBCookingdetailModel *cookingModel = [[LXBCookingdetailModel alloc] init];
        cookingModel.name = @"餐位费";
        NSInteger tableware = [deskModel.tableware integerValue];
        CGFloat tableFee = [deskModel.tableFee floatValue];
        if (tableFee == 0 || tableware == 0) {
            cookingModel.price = [NSString stringWithFormat:@"0.0"];
        }else {
            
            CGFloat price = tableFee / tableware;
            cookingModel.price = [NSString stringWithFormat:@"%.2f",price];
        }
        CGFloat total = [cookingModel.quantity integerValue] * [cookingModel.price floatValue];
        cookingModel.quantity = [NSString stringWithFormat:@"%@",deskModel.tableware];
        NSDictionary *foodDic = @{@"Name":cookingModel.name,@"Price":cookingModel.price,@"Number":cookingModel.quantity,@"Sum":[NSString stringWithFormat:@"%.2f",total]};
        [foodArr addObject:foodDic];
    } else {
    }
    [[BFOrderServices alloc] printOrderTableNum:deskModel.name printIp:[BFUserSignelton shareBFUserSignelton].printer_addr waiterName:[BFUserSignelton shareBFUserSignelton].truename orderNum:_mDic[@"orderSn"] time:_mDic[@"create_date"] personNum:_mDic[@"number"] orderDetail:foodArr coupons:@"0" remark:StringValue(_mDic[@"remark"]) SuccessBlock:^(id result) {
//        [BFUtils showAlertController:0 title:@"" message:@"已打印好订单"];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
}
#pragma mark - 给子视图复制
- (void)configUISetValue {
    
    _headerTitleLab.text = [NSString stringWithFormat:@"%@%@",self.mDic[@"areaName"],self.mDic[@"deskName"]];
    LXBDingInfoModel * model = [[LXBDingInfoModel alloc]init];
    [model yy_modelSetWithDictionary:_mDic];
    _dingInfoView.model = model;
}
#pragma mark - buttton的点击事件
- (void)makeSuerAction:(UIButton *)sender {
    
	BFPaymentWayController *subtotalVC = [[BFPaymentWayController alloc] init];
	subtotalVC.orderId = self.orderIds;
    BFDeskModel *deskModel = [_dataArr lastObject];
    subtotalVC.desk_id = [NSString stringWithFormat:@"%@",deskModel.deskId];
	UINavigationController *nagVC = (UINavigationController *)KEY_WINDOW.rootViewController;
	[nagVC pushViewController:subtotalVC animated:YES];
    WS(weakSelf);
	subtotalVC.tapBlock = ^{
        [weakSelf printOrderRequest];
    };
}
#pragma mark - get方法

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-KSpace * 2, KhederViewH)];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerTitleLab = [[UILabel alloc] init];
        _headerTitleLab.font = [UIFont boldSystemFontOfSize:BF_FONTSIZE_a4];
        _headerTitleLab.textColor = [UIColor colorWithHex:BF_COLOR_B0];
        [_headerView addSubview:_headerTitleLab];
        _headerTitleLab.adjustsFontSizeToFitWidth = YES;
        _headerTitleLab.textAlignment = NSTextAlignmentCenter;
        [_headerTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headerView);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(120);
            
        }];
        _headerTitleLab.backgroundColor = [UIColor colorWithHex:BF_COLOR_L26];
    }
    return _headerView;
}

- (BFDingInfoView *)dingInfoView
{
    if (_dingInfoView == nil) {
        _dingInfoView = [[BFDingInfoView alloc] initWithFrame:CGRectMake(KSpace, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH - KSpace * 2, KDingInfoViewH)];
    }
    return _dingInfoView;
}
-(UITableView *)lxbTableView {
    if (!_lxbTableView) {
        CGFloat tbHeight;
        if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 3 ){
            tbHeight = SCREEN_HEIGHT - (KNavBarHeight + KhederViewH + KDingInfoViewH + KOrderButtonH + KMargin * 4);
        }else {
            tbHeight =  SCREEN_HEIGHT  - (KNavBarHeight + KhederViewH + KDingInfoViewH  + KMargin * 2);
        }
        _lxbTableView = [[BFSubTableView alloc]initWithFrame:CGRectMake(KSpace, CGRectGetMaxY(self.dingInfoView.frame) + KMargin, SCREEN_WIDTH-KSpace * 2, tbHeight) style:UITableViewStylePlain];
        _lxbTableView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_lxbTableView];
    }
    return _lxbTableView;
}

- (UIButton *)affirmOrderButton {
    if (!_affirmOrderButton) {
        _affirmOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_affirmOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_affirmOrderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//        UIImage *imag = [self imageWithColor:[UIColor colorWithRed:220.0/255.0 green:69.0/255.0 blue:29.0/255.0 alpha:1.0]];
		[self.view addSubview:self.affirmOrderButton];
//        [_affirmOrderButton setBackgroundImage:imag forState:UIControlStateNormal];
        if ([[BFUserSignelton shareBFUserSignelton].isPay integerValue] == 1) {
            [_affirmOrderButton setBackgroundColor:[UIColor lightGrayColor]];
            _affirmOrderButton.enabled = NO;
        }else{
            [_affirmOrderButton setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B11]];

        }
        _affirmOrderButton.layer.masksToBounds = YES;
        _affirmOrderButton.layer.cornerRadius = 5.0f;
        [_affirmOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(KSpace);
            make.right.equalTo(self.view).offset(-KSpace);
            make.bottom.equalTo(self.view).offset(-20);
            make.height.mas_equalTo(KOrderButtonH);
        }];
    }
    
    return _affirmOrderButton;
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


