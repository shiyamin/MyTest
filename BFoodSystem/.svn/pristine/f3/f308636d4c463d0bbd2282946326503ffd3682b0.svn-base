//
//  BFDingInfoView.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/26.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDingInfoView.h"

@interface BFDingInfoView ()
@property (nonatomic, weak) UILabel *DiningTepyLab;//用餐类型
@property (nonatomic, weak) UILabel *DiningNumLab;//用餐人数
@property (nonatomic, weak) UILabel *DiningTimeLab;//用餐时间
@property (nonatomic, weak) UILabel *DingOrderIDLab;// 订单号显示

@end

@implementation BFDingInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self LXBCreationView];
    }
    return self;
}

- (void)LXBCreationView {
    

    UIColor *textColor = [UIColor colorWithHex:BF_COLOR_B3];
    UIFont *textFont = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    UIView *sub = self;
    self.backgroundColor = [UIColor clearColor];
    sub.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    //添加边框
//    self.layer.cornerRadius = 4.0f;
//    self.layer.borderWidth = 1.0f;
//    self.layer.borderColor = [UIColor colorWithHex:BF_COLOR_L19].CGColor;
    UILabel *DiningTepyLabel = [UILabel new];
    DiningTepyLabel.font = textFont;
    DiningTepyLabel.textColor = textColor;
    [sub addSubview:DiningTepyLabel];
    _DiningTepyLab = DiningTepyLabel;
    [DiningTepyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub).offset(12);
        make.left.equalTo(sub).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(sub.frame.size.width/2);
    }];
    
    UILabel *DingOrderID = [[UILabel alloc] init];
    DingOrderID.font = textFont;
    DingOrderID.textColor = textColor;
    DingOrderID.textAlignment = NSTextAlignmentRight;
    DingOrderID.numberOfLines = 0;
    //    DingOrderID.lineBreakMode = UILineBreakModeCharacterWrap;
    [sub addSubview:DingOrderID];
    _DingOrderIDLab = DingOrderID;
    [DingOrderID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub).offset(8);
        make.right.equalTo(sub).offset(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(sub.frame.size.width/2);
    }];
    
    UILabel *DiningNumLabel = [[UILabel alloc] init];;
    DiningNumLabel.font = textFont;
    DiningNumLabel.textColor = textColor;
    [sub addSubview:DiningNumLabel];
    _DiningNumLab = DiningNumLabel;
    [DiningNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(DiningTepyLabel.mas_bottom).offset(10);
        make.left.equalTo(sub).offset(10);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *DiningTimeLabel = [UILabel new];
    DiningTimeLabel.font = textFont;
    DiningTimeLabel.textColor = textColor;
    [sub addSubview:DiningTimeLabel];
    _DiningTimeLab = DiningTimeLabel;
    [DiningTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(sub).offset(-12);
        make.left.equalTo(sub).offset(10);
        make.height.mas_equalTo(16);
        make.right.equalTo(sub).offset(-10);
    }];
    
    
    
}

- (void)setModel:(LXBDingInfoModel *)model
{
    _model = model;
    _DiningTepyLab.text = [NSString stringWithFormat:@"餐台类型:  %@", model.type];
    _DingOrderIDLab.text = [NSString stringWithFormat:@"订单号: %@",model.orderSn];
    _DiningNumLab.text = [NSString stringWithFormat:@"用餐人数:  %@",model.number];
    _DiningTimeLab.text = [NSString stringWithFormat:@"用餐开始时间:  %@",[model.create_date substringFromIndex:11]];
    
}


@end
