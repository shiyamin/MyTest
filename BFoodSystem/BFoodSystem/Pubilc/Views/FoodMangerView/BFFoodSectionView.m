//
//  BFFoodSectionView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodSectionView.h"


@interface BFFoodSectionView ()

@property (nonatomic, strong)UILabel *titleLab;


@end

@implementation BFFoodSectionView




- (instancetype)init{
    if (self = [super init]) {
        [self setStatusForSubViews];
    }
    return self;
}


- (void)setStatusForSubViews{
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B11];
    [self addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(3);
    }];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.titleLab.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(5);
        make.top.bottom.equalTo(leftLineView);
        make.right.equalTo(self).offset(-5);
    }];
    
    
}



- (void)congfigSectionHeadInfo:(NSString *)titleStr{
    self.titleLab.text =  titleStr;
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
