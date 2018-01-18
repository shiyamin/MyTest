//
//  BFLoginViewController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFLoginViewController.h"
#import "BFRegistController.h"
#import "BFLoginServices.h"
#import "BFAppServices.h"



@interface BFLoginViewController ()

@end

@implementation BFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviewStatus];
    
    //保存第一次启动的信息
    NSUserDefaults *userdefauls = [NSUserDefaults standardUserDefaults];
    [userdefauls setObject:[BFUtils clientVersionCode] forKey:@"appVersion"];
    
   NSString *autoLogin = [userdefauls objectForKey:@"isAutoLogin"];
    if (autoLogin && [autoLogin isEqualToString:@"YES"]) {
        [self autoLogin];
    }
    [userdefauls synchronize];
    
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    NSString *psdStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    [self setUserName:userName passWordStr:psdStr];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)setSubviewStatus{
    self.titleLable.textColor = [UIColor colorWithHex:@"#7b7c80"];
    
    [self.loginBtn setBackgroundColor:[UIColor colorWithHex:@"#e55c25"]];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
    
    self.otherLoginLable.hidden = YES;
    self.weChatLoginBtn.hidden = YES;
    self.payLoginBtn.hidden = YES;
    
    [self.weChatLoginBtn setBackgroundImage:[UIImage imageNamed:@"dl_weixin"] forState:UIControlStateNormal];
    [self.payLoginBtn setBackgroundImage:[UIImage imageNamed:@"dl_zhifubao"] forState:UIControlStateNormal];

}


- (void)setUserName:(NSString *)userStr passWordStr:(NSString *)psdStr{
    self.userLableTF.text = userStr;
    self.passwordTF.text = psdStr;
}


- (IBAction)loginBtnAction:(UIButton *)sender {
    
    NSString *userNameStr = self.userLableTF.text;
    NSString *psdStr = self.passwordTF.text;
    if (userNameStr.length == 0) {
        [BFUtils showAlertController:1 title:@"" message:@"请输入正确的手机号码"];
        return;
    }
    [self.view endEditing:YES];
    [self loginRequestWithUserName:userNameStr passWord:psdStr];
    
}

- (void)loginRequestWithUserName:(NSString *)userNameStr passWord:(NSString *)psdStr{
    [BFUtils showProgressHUDWithTitle:@"加载中...." inView:self.view animated:YES];

    [[BFLoginServices alloc] userLoginWithUserName:userNameStr password:psdStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        NSString *type = (NSString *)result;
        
        //type为1是管理员，否则就是收银员或者服务员**//
        if ([type integerValue] == 1) {
            [BFUtils setRootViewControllerWithHomeViewController];
        }else {
            [BFUtils setRootViewControllerWithWaiterViewController];
        }
        
        NSString *regisID = [[NSUserDefaults standardUserDefaults] objectForKey:@"jpush"];
        [[BFAppServices alloc] appinfoToServicesWithToken:[BFUserSignelton shareBFUserSignelton].token registrationId:regisID ver:[BFUtils clientVersionCode] uuid:getIphoneUUID() phone:getDeviceName() sys:getOSVersion()];

    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        if (errorCode == 1024 || errorCode == 1025 ||errorCode == 1026) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSScanner *scanner = [NSScanner scannerWithString:errorMessage];
                [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
                int number;
                [scanner scanInt:&number];
                BFLog(@"number : %d", number);
                NSString *telStr = [NSString stringWithFormat:@"tel://%d",number];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
                
            }];
            [alert addAction:confirm];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }else{
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        }
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];

    

}


//注册按钮
- (IBAction)pushRegistAction:(UIButton *)sender {
    BFRegistController *registVc = [[BFRegistController alloc] init];
    registVc.loginVc = self;
    [self.navigationController pushViewController:registVc animated:YES];
}


//忘记密码按钮
- (IBAction)pushForgetAction:(UIButton *)sender {
    BFRegistController *registVc = [[BFRegistController alloc] init];
    registVc.selfType = @"changPsd";
    registVc.loginVc = self;
    [self.navigationController pushViewController:registVc animated:YES];
}


- (IBAction)weChatLoginAction:(UIButton *)sender {
    
}

- (IBAction)payLoginAction:(UIButton *)sender {
    
}


- (void)autoLogin{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    NSString *psdStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    [self loginRequestWithUserName:userName passWord:psdStr];
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
