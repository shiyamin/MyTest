//
//  ZJFMessageDetailViewController.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFMessageDetailViewController.h"

@interface ZJFMessageDetailViewController ()

@end

@implementation ZJFMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    [self setStatusForSubViews];
//    BFLog(@"listModel = %@", self.listModel);
}

- (void)setStatusForSubViews {

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 50)];
    titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    titleLabel.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"标题：%@",self.listModel.title];
    [self.view addSubview:titleLabel];
    
    UILabel *releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, WIDTH_SCREEN/2, 25)];
    releaseLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    releaseLabel.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    NSArray *temp = [self.listModel.title componentsSeparatedByString:@"消"];
    releaseLabel.text = [NSString stringWithFormat:@"发布者:%@",temp[0]];
    [self.view addSubview:releaseLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, 50, WIDTH_SCREEN/2-20, 25)];
    timeLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    timeLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.text = self.listModel.creatTime;
    [self.view addSubview:timeLabel];
    
    //系统发送消息 14pt #808080
    UITextView *textView = [[UITextView alloc] init];
    
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [textView setEditable:NO];
    textView.text =  self.listModel.content;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view);
    }];
}

- (void)dealloc {
   
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
