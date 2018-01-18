//
//  BFWaiterHomehdView.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterHomehdView.h"
#import "UIButton+BFRedButton.h"
@interface BFWaiterHomehdView ()
{
    UILabel *waiterNameLb;
    UIButton *waiterExistBut;
    UILabel *waiterTimeLb;
}
@end
@implementation BFWaiterHomehdView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //初始化UI;
        [self configSbView];
    }
    return self;
}
- (void)setWaiteName:(NSString *)waiteName
{
    _waiteName = waiteName;
    waiterNameLb.text = waiteName;
    
}
- (void)setWaiterTime:(NSString *)waiterTime
{
    _waiteName = waiterTime;
    waiterTimeLb.text = waiterTime;
    
}
 - (void)configSbView
{
    waiterNameLb = [[UILabel alloc] init];
    waiterNameLb.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    waiterNameLb.textColor = [UIColor colorWithHex:@"#3c3e48"];
    waiterNameLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:waiterNameLb];
    [waiterNameLb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [waiterNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.top.mas_equalTo(self);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    waiterTimeLb = [[UILabel alloc] init];
    waiterTimeLb.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    waiterTimeLb.textColor = [UIColor colorWithHex:@"#3c3e48"];
    waiterTimeLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:waiterTimeLb];
    [waiterTimeLb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [waiterTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.top.mas_equalTo(self);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    waiterExistBut = [UIButton configUniversalWithTitle:@"退出" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_L17 withBgImage:nil withBgColor:nil];
    [self addSubview:waiterExistBut];
    [waiterExistBut addTarget:self action:@selector(waiteExistAction:) forControlEvents:UIControlEventTouchUpInside];
    [waiterExistBut setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [waiterExistBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(waiterNameLb.mas_right).with.offset(20);
        make.top.mas_equalTo(self);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    
    
}

#pragma mark - 退出服务员的操作
- (void)waiteExistAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(logoutAction)]) {
        [self.delegate logoutAction];
    }
}
- (void)dealloc {
//    BFLog(@"%s", __func__);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
