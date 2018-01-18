//
//  BFWaiterController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/16.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterController.h"
#import "BFWaiterHomehdView.h"
#import "BFWaiterHomeListView.h"
#import "UIButton+BFRedButton.h"
#import "BFSearchTextField.h"
#import "BFLoginServices.h"
#import "LXBDiningTableViewController.h"
#import "BFShopServices.h"
#import "LXBNewsController.h"
#import "BFShopServices.h"
#import "JPUSHService.h"
#import "LXBComfirmOrderViewController.h"
#import "BFPrintManger.h"

@interface BFWaiterController ()<UITextFieldDelegate,BFWaiterHomehdViewDelegate>
{
    BFSearchTextField *searchField;
    LXBDiningTableViewController *_collVc;
}

@property (nonatomic, assign)BOOL inSearch;
@property (nonatomic, strong) LXBNewsController *newsVC;
@property (strong, nonatomic)  BFWaiterHomeListView *listView;
@property (strong, nonatomic) UIImageView *tipImageView;


@end

@implementation BFWaiterController



- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 2) {
        self.title = @"服务员";
    }else {
        self.title = @"收银员";
    }
  
    //名字和时间应该是从外面传入的
    self.waiteName = @"";
    self.waiterTime = @"";
    self.inSearch = NO;
    [self waiterHomeConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshCollectionViewWithNotifition)
                                                 name:updateWaiterDeskNotification
                                               object:nil];
    
    [self searchDeskRequestAction];

}

- (void)loadData
{
    [[BFShopServices alloc] getMessageListInfoWithMessageType:@"2" SuccessBlock:^(id result) {
        NSMutableArray *data = [(NSMutableArray *)result lastObject];
        if (data.count == 0) {
            _tipImageView.hidden = YES;
        } else  if (data.count > 0) {
            _tipImageView.hidden = NO;
        }
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

//视图的创建
#pragma mark - 首页视图
- (void)waiterHomeConfig
{
    // 导航栏刷新按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shauxin1"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickedOKbtn)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    //头部视图
    BFWaiterHomehdView *hedView = [[BFWaiterHomehdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    hedView.backgroundColor = [UIColor colorWithHex:BF_COLOR_L16];
    hedView.delegate = self;
    [self.view addSubview:hedView];
    hedView.waiteName = [BFUserSignelton shareBFUserSignelton].truename;
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formater setDateFormat:@"YYYY-MM-dd"];
    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [formater stringFromDate:nowDate];
    hedView.waiterTime = nowStr;
    
    
    //列表视图
    
    _listView = [[BFWaiterHomeListView alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 170)];
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.waiterVC = self;
    [self.view addSubview:_listView];
    
    
    //创建蓝牙连接的按钮
    UIButton *lanyaBtn = [UIButton configUniversalWithTitle:@"打开连接（蓝牙）" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B10 withBgImage:nil withBgColor:nil];
    [lanyaBtn setButtonRedStatus];
    [self.view addSubview:lanyaBtn];
    [lanyaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.top.mas_equalTo(_listView.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    [lanyaBtn addTarget:self action:@selector(linkBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建消息中心的按钮
    UIButton *messageBut = [UIButton configUniversalWithTitle:@"消息中心" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B10 withBgImage:nil withBgColor:nil];
    [messageBut setButtonRedStatus];
    [self.view addSubview:messageBut];
    [messageBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.top.mas_equalTo(lanyaBtn.mas_bottom).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    [messageBut addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _tipImageView = [[UIImageView alloc] init];
    [_tipImageView setImage:[UIImage imageNamed:@"dian"]];
    [self.view addSubview:_tipImageView];
    [_tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageBut.mas_top).with.offset(-10);
        make.right.mas_equalTo(messageBut.mas_right).with.offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo (20);
    }];
    _tipImageView.hidden = YES;
    
    //搜索的btn
    UIButton *searchBut = [UIButton configUniversalWithTitle:@"搜索" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B10 withBgImage:nil withBgColor:nil];
    [searchBut addTarget:self action:@selector(searchDeskRequestAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBut];
    [searchBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageBut.mas_bottom).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    searchBut.layer.borderWidth = 1.0;
    searchBut.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
    searchBut.layer.cornerRadius = 5.0;
    
   // 搜索框的设置
    searchField = [BFSearchTextField searchBarWithTitle:@"请输入餐台名搜索" withImage:@"sy_sousuo"];
    [self.view addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.top.mas_equalTo(messageBut.mas_bottom).with.offset(20);
        make.right.mas_equalTo(searchBut.mas_left).with.offset(-10);
        make.height.mas_equalTo(30);
    }];
    searchField.delegate = self;
    
    //餐台列表界面
    LXBDiningTableViewController *collecVc = [[LXBDiningTableViewController alloc] init];
    [self addChildViewController:collecVc];
    [collecVc.view setFrame:CGRectMake(0, 400, SCREEN_WIDTH, SCREEN_HEIGHT-420)];
    [collecVc hiddenTopTitleLable];
    _collVc = collecVc;
    [self.view addSubview:collecVc.view];
   
}

- (void)onClickedOKbtn {
    
    [_listView loadData];
    //    [self refreshCollectionViewWithNotifition];
    [self searchDeskRequestAction];
}

//退出按钮
- (void)logoutAction{
    
    [[BFUserSignelton shareBFUserSignelton] logoutClearUserInfo];
    
    [[BFLoginServices alloc] logoutWithSuccessBlock:^(id result) {
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 连接蓝牙按钮的点击事件
- (void)linkBtn:(UIButton *)btn{
    BFLog(@"======%@", @"连接蓝牙");
    
}
#pragma mark - 消息按钮的点击事件
- (void)messageAction:(UIButton *)sender {
    [searchField resignFirstResponder];
    LXBNewsController *newsVC = [[LXBNewsController alloc] init];
    UINavigationController *navgVC = (UINavigationController *)KEY_WINDOW.rootViewController;
    [navgVC pushViewController:newsVC animated:YES];
    
}

- (void)refreshCollectionViewWithNotifition{
    
    if (self.inSearch) {
        [self searchDeskRequestAction];
    }
}

#pragma mark -- 获取极光消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *extras = [userInfo objectForKey:@"extras"];

    if (extras != nil || extras != NULL) {
        
        NSString *content = [userInfo objectForKey:@"content"];
        NSString *messageID = [extras objectForKey:@"msg_id"];
        NSString *type = [extras objectForKey:@"type"];
//        [BFUserSignelton shareBFUserSignelton].printer_addr = [extras objectForKey:@"printer_addr"];
        
        if ([type integerValue] == 2) {  // 呼叫消息处理
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:content preferredStyle:UIAlertControllerStyleAlert];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[BFShopServices alloc] confirmCallMessageWithMessageId: messageID SuccessBlock:^(id result) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];

                     [BFUtils showAlertController:0 title:@"" message:@"信息发送成功"];

                 
                } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];

                    
                } Failure:^(NSError *error) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];

                }];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
        } else if ([type integerValue] == 1) { // 打印传菜单和小票
            
           NSString *orderId = [extras objectForKey:@"out_trade_no"];
            NSString *printerIp = [extras objectForKey:@"printer_addr"];
            [[BFPrintManger alloc] printMessageWithOrderId:orderId printIp:printerIp success:^(NSString *result) {
                
            } failue:^(NSString *errorStr) {
                
            }];
        }else if([type integerValue] == 3){   //服务员确认后打印传菜单
            if (![BFUserSignelton shareBFUserSignelton].isPushConfirmVc) {
                LXBComfirmOrderViewController *orderVC = [[LXBComfirmOrderViewController alloc] init];
                orderVC.notificationDic = userInfo;
                [self.navigationController pushViewController:orderVC animated:YES];
                [BFUserSignelton shareBFUserSignelton].isPushConfirmVc = YES;
            }
            
        }else if ([type integerValue] == 4){  //收银员点击付款后，打印小票
            
            NSString *orderId = [extras objectForKey:@"out_trade_no"];
            NSString *printerIp = [extras objectForKey:@"printer_addr"];
            [[BFPrintManger alloc] printPassOrder:orderId printIp:printerIp success:^(NSString *result) {
                
            } failue:^(NSString *errorStr) {
                
            }];
        }
        
    }
}

- (void)searchDeskRequestAction{
    
    [searchField resignFirstResponder];
    [BFUtils showProgressHUDWithTitle:@"搜索中..." inView:self.view animated:YES];
    [[BFShopServices alloc] getDeskListDetailWithDeskName:searchField.text SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        _collVc.deskArr = (NSArray *)result;
        self.inSearch = YES;
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)dealloc{
    BFLog(@"******************deallocdeallocdeallocdealloc*********************");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:updateWaiterDeskNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidReceiveMessageNotification object:nil];
}


#pragma mark - textField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
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
