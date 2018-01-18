//
//  BFWaiteHomeListCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiteHomeListCell.h"

@implementation BFWaiteHomeListCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHex:BF_COLOR_L18];
        [self configSbView];
    }
    return self;
}

- (void)configSbView
{
    UILabel *tilte = [[UILabel alloc] init];
    tilte.tag = 100;
    tilte.font = [UIFont systemFontOfSize:16];
    tilte.textAlignment = NSTextAlignmentCenter;
    tilte.textColor = [UIColor whiteColor];
    [self addSubview:tilte];
    [tilte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];

}

- (void)setModel:(BFAreaModel *)model
{
    _model = model;
    UILabel *lab = [self viewWithTag:100];
    NSString *name = model.name;
    lab.text = [NSString stringWithFormat:@"%@",name];
}

@end
