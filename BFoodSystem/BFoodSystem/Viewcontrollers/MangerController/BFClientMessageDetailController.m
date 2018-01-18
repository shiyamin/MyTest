//
//  BFClientMessageDetailController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFClientMessageDetailController.h"

@interface BFClientMessageDetailController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BFClientMessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    [self creatSubViews];
}


- (void)creatSubViews{
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.left.equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Home/message/index/id/%@",webURL,self.listModel.messageId]]]];
    BFLog(@"%@",[NSString stringWithFormat:@"%@/Home/message/index/id/%@",webURL,self.listModel.messageId] );
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
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
