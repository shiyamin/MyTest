//
//  BFDingNoPeopleController.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/7.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDingNoPeopleController.h"
#import "UIButton+BFRedButton.h"
#import "BFAddFoodController.h"


@interface BFDingNoPeopleController ()

@end

@implementation BFDingNoPeopleController


#pragma mark - 对象销毁


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
}

- (void)createSubViews {
    
    //图片
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"qy_cantai"];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(100);
    }];
    
    //开台
    UIButton *but = [UIButton configUniversalWithTitle:@"开台" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B0 withBgImage:nil withBgColor:BF_COLOR_B10];
    [self.view addSubview:but];
    [but setButtonRedStatus];
    
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.top.mas_equalTo(imgView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [but addTarget:self action:@selector(beginDeskAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)beginDeskAction:(UIButton *)sender {

    NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@""];
    [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
    [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
    NSString *alertMessage = [NSString stringWithFormat:@"请输入用餐人数(%@人用餐最佳)",_deskModel.num];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:buttonTitle forKey:@"attributedTitle"];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"用餐人数";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTf = alertController.textFields.firstObject;
        BFLog(@"用餐人数====%@", nameTf.text);
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if (nameTf.text.length<1 || [nameTf.text integerValue] == 0) {
            return ;
        }
        
        BFAddFoodController *addFoodVc = [[BFAddFoodController alloc] init];
        addFoodVc.eatPersonNum = nameTf.text;
        addFoodVc.deskModel = self.deskModel;
        [self.navigationController pushViewController:addFoodVc animated:YES];
        
    }];
    
    
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setName:(NSString *)name
{
    _name = name;
    self.title = _name;
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
