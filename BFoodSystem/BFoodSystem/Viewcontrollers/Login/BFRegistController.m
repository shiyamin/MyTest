//
//  BFRegistController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//
//注册  忘记密码共用一个
#import "BFRegistController.h"
#import "BFLoginServices.h"
#import "BFLoginViewController.h"

@interface BFRegistController ()


@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeCount;
@property (nonatomic, assign) NSInteger begainTime;


@end




@implementation BFRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    //重置密码
    if ([self.selfType isEqualToString:@"changPsd"]) {
        self.title = @"重置密码";
    }
    [self setStatusForSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

//布局子控件的属性值
- (void)setStatusForSubviews{
    self.titleLable.textColor = [UIColor colorWithHex:@"#7b7c80"];
    
    [self.registBtn setBackgroundColor:[UIColor colorWithHex:@"#e55c25"]];
    self.registBtn.layer.cornerRadius = 5;
    self.registBtn.clipsToBounds = YES;
    
    
    if ([self.selfType isEqualToString:@"changPsd"]) {
        [self.registBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    [self.sendCodeBtn setBackgroundImage:imageFromColor([UIColor colorWithHex:@"#e55c25"]) forState:UIControlStateNormal];
    [self.sendCodeBtn setBackgroundImage:imageFromColor([UIColor colorWithHex:@"#cacaca"]) forState:UIControlStateDisabled];
    self.sendCodeBtn.layer.cornerRadius = 5;
    self.sendCodeBtn.clipsToBounds = YES;
    
    if ([self.selfType isEqualToString:@"changPsd"]) {
        self.firPsdTF.placeholder = @"请输入新密码";
    }
}


//发送验证码操作
- (IBAction)smsCodeAction:(UIButton *)sender {
    NSString *userNameStr = self.userNameTF.text;
    if (userNameStr.length != 11) {
        [BFUtils showAlertController:1 title:@"提示" message:@"请输入正确的手机号码"];
        return;
    }
    [self sendSMSRequestWithName:userNameStr];
    
}


- (void)sendSMSRequestWithName:(NSString *)nameStr{
    
    NSString *codeType = @"register";
    
    if ([self.selfType isEqualToString:@"changPsd"]) {
        codeType = @"findPass";
    }
    [BFUtils showProgressHUDWithTitle:@"发送中...." inView:self.view animated:YES];

    [[BFLoginServices alloc] getSMSCodeWithPhoneNum:nameStr sendType:codeType SuccessBlock:^(id result) {
    
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"发送成功"];
        self.begainTime = [[NSDate date] timeIntervalSince1970];
        self.timeCount = 121;
        _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        self.sendCodeBtn.enabled = NO;
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

- (void)timeChange
{
    // 倒计时
    if (self.timeCount == 0){
        [self timeComple];
        self.sendCodeBtn.enabled = YES;
        return;
    }
    self.timeCount = 120 - (NSInteger)([[NSDate date] timeIntervalSince1970] - self.begainTime);
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.timeCount] forState:UIControlStateNormal];
}


- (void)timeComple
{
    [_timer invalidate];
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
    self.timeCount = 61;
    
}



//注册
- (IBAction)registBtnAction:(UIButton *)sender {
    
    NSString *userNameStr = self.userNameTF.text;
    NSString *firPsdStr = self.firPsdTF.text;
    NSString *secPsdStr = self.secPsdTf.text;
    NSString *smsStr = self.smsCodeTf.text;
    
    if (userNameStr.length != 11) {
        [BFUtils showAlertController:1 title:@"" message:@"请输入正确的手机号码"];
        return;
    }
    if (smsStr.length<4) {
        [BFUtils showAlertController:1 title:@"" message:@"请输入正确的验证码"];
        return;
    }
    
    
    if(firPsdStr.length<6){
        [BFUtils showAlertController:1 title:@"" message:@"请输入六位以上的密码"];
        return;
    }
    
    if(![firPsdStr isEqualToString:secPsdStr]){
        [BFUtils showAlertController:1 title:@"" message:@"两次密码不一致"];
        return;
    }
    [self.view endEditing:YES];
    [BFUtils showProgressHUDWithTitle:@"加载中...." inView:self.view animated:YES];
    
    //修改密码
    if ([self.selfType isEqualToString:@"changPsd"]) {
        
       [[BFLoginServices alloc] findPasswordWithUserName:userNameStr password:firPsdStr smsCode:smsStr SuccessBlock:^(id result) {
           [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
           [self.loginVc setUserName:userNameStr passWordStr:firPsdStr];
           UIAlertController * alert = [BFUtils alertController:nil message:@"密码修改成功"];
           UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [self.navigationController popViewControllerAnimated:YES];
           }];
           [alert addAction:confirm];
       } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
           [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
           [BFUtils showAlertController:0 title:@"" message:errorMessage];
           
       } Failure:^(NSError *error) {
           [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
           [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
       }];
        
   }else{
        [[BFLoginServices alloc] userRegistWithUserName:userNameStr password:firPsdStr smsCode:smsStr SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            BFLog(@"注册之后===%@", result);
            UIAlertController * alert = [BFUtils alertController:nil message:@"注册成功"];
            [self.loginVc setUserName:userNameStr passWordStr:firPsdStr];
            UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.loginVc.userLableTF.text = userNameStr;
                self.loginVc.passwordTF.text = firPsdStr;
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:confirm];

        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
            
        } Failure:^(NSError *error) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
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
