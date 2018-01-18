//
//  BFBusinessHeadView.m
//  BFoodSystem
//
//  Created by 浙江择富 on 2018/1/17.
//  Copyright © 2018年 陈名正. All rights reserved.
//

#import "BFBusinessHeadView.h"

@implementation BFBusinessHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self ) {
        
        _nameLab = [[UILabel alloc] init];
         _nameLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];
         _nameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a4];
        [self addSubview: _nameLab];

        _tf = [[UITextField alloc]init];
        _tf.font = [UIFont systemFontOfSize:BF_FONTSIZE_a4];
        [self addSubview:_tf];

        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHex:@"#aeaeae"];
        [self addSubview:_lineView];
    
    }
    
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.equalTo(self).offset(20);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(120);
    }];


    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab);
        make.left.mas_equalTo(self.nameLab.mas_right);
        make.bottom.mas_equalTo(self.nameLab);
        make.right.equalTo(self).offset(-20);

    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tf.mas_bottom);
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.right.mas_equalTo(self.tf);
        make.height.mas_equalTo(1);
    }];


}
@end
