//
//  BFLoginViewController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFLoginViewController : BFBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLable;



@property (weak, nonatomic) IBOutlet UITextField *userLableTF;


@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (weak, nonatomic) IBOutlet UIButton *weChatLoginBtn;


@property (weak, nonatomic) IBOutlet UIButton *payLoginBtn;

@property (weak, nonatomic) IBOutlet UILabel *otherLoginLable;

@property (weak, nonatomic) IBOutlet UIView *passLineView;

@property (weak, nonatomic) IBOutlet UIView *userLIneView;


- (void)setUserName:(NSString *)userStr passWordStr:(NSString *)psdStr;
@end
