//
//  BFScrollFirView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFScrollFirView.h"

#import "BFInfoNumView.h"

@interface BFScrollFirView ()

@property (nonatomic, strong)BFInfoNumView *paltformView;
@property (nonatomic, strong)BFInfoNumView *cashView;
@property (nonatomic, strong)BFInfoNumView *wechatView;
@property (nonatomic, strong)BFInfoNumView *payView;
@property (nonatomic, strong)BFInfoNumView *bankCardView;
@property (nonatomic, strong)BFInfoNumView *memberView;
@property (nonatomic, strong)BFInfoNumView *groupBuyView;


@end

@implementation BFScrollFirView


- (instancetype)init{
    if (self = [super init]) {
        [self creatSubviews];
    }
    return self;
}


- (void)creatSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"当日收益(元)";
    titleLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    self.paltformView = [[BFInfoNumView alloc] init];
    self.paltformView.titleLable.text = @"平台";
    self.paltformView.numLable.text = @"0.00元";
    [self addSubview:self.paltformView];
    [self.paltformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    self.cashView = [[BFInfoNumView alloc] init];
    self.cashView.titleLable.text = @"现金";
    self.cashView.numLable.text = @"0.00元";
    [self addSubview:self.cashView];
    [self.cashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.paltformView);
        make.height.mas_equalTo(50);
    }];
    
    
    self.wechatView = [[BFInfoNumView alloc] init];
    self.wechatView.titleLable.text = @"微信";
    self.wechatView.numLable.text = @"0.00元";
    [self addSubview:self.wechatView];
    [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.paltformView);
        make.height.mas_equalTo(50);
    }];
    
    self.payView = [[BFInfoNumView alloc] init];
    self.payView.titleLable.text = @"支付宝";
    self.payView.numLable.text = @"0.00元";
    [self addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatView.mas_bottom).offset(5);
        make.height.mas_equalTo(50);
    }];
    
    
    self.bankCardView = [[BFInfoNumView alloc] init];
    self.bankCardView.titleLable.text = @"银行卡";
    self.bankCardView.numLable.text = @"0.00元";
    [self addSubview:self.bankCardView];
    [self.bankCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.payView);
    }];
    
    
    self.memberView = [[BFInfoNumView alloc] init];
    self.memberView.titleLable.text = @"会员卡";
    self.memberView.numLable.text = @"0.00元";
    [self addSubview:self.memberView];
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.payView);
    }];
    
    self.groupBuyView = [[BFInfoNumView alloc] init];
    self.groupBuyView.titleLable.text = @"美团";
    self.groupBuyView.numLable.text = @"0.00元";
    [self addSubview:self.groupBuyView];
    [self.groupBuyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.payView);
    }];
    
    
    NSArray *firArr = @[self.paltformView,self.cashView,self.wechatView];
    [firArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:40 tailSpacing:40];
    
    NSArray *secArr = @[self.payView,self.bankCardView,self.memberView,self.groupBuyView];
    [secArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:20 tailSpacing:20];

}





- (void)setFirViewInfoWith:(BFQueryDailyModel *)mdoel{
    
    self.paltformView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.platform];
    self.wechatView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.weixin];
    self.cashView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.cash];
    self.payView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.alipay];
    self.bankCardView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.bank];
    self.memberView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.member];
    self.groupBuyView.numLable.text = [NSString stringWithFormat:@"%@元",mdoel.meituan];


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
