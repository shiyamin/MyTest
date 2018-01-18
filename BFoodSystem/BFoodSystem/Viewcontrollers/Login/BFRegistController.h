//
//  BFRegistController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"

@class BFLoginViewController;

@interface BFRegistController : BFBaseViewController


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@property (weak, nonatomic) IBOutlet UITextField *smsCodeTf;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *firPsdTF;

@property (weak, nonatomic) IBOutlet UITextField *secPsdTf;


@property (weak, nonatomic) IBOutlet UIButton *registBtn;


//区分是注册界面还是忘记密码界面的标记
@property (nonatomic, copy) NSString *selfType;

@property (nonatomic, strong)BFLoginViewController *loginVc;

@end
