//
//  BFDeskSelectView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskSelectView.h"

@interface BFDeskSelectView ()

@property (nonatomic, strong) UIImageView *backGroundImage;




@end


@implementation BFDeskSelectView


- (instancetype)init{
    if (self = [super init]) {
        [self setStatusForSubviews];
    }
    return self;
}


- (void)setStatusForSubviews{
    self.backGroundImage = [[UIImageView alloc] init];
    [self addSubview:self.backGroundImage];
    [self.backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    self.titleImageView = [[UIImageView alloc] init];
    [self.backGroundImage addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backGroundImage);
        make.left.equalTo(self.backGroundImage).offset(20);
        make.width.mas_offset(150);
        make.height.mas_offset(50);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    
    
}

- (void)setTitleImageViewFrame{
    [self.titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280);
    }];
    
}

- (void)configBackGroundImage:(NSString *)imageName titleImage:(NSString *)titleImgName{
    [self.backGroundImage setImage:[UIImage imageNamed:imageName]];
    [self.titleImageView setImage:[UIImage imageNamed:titleImgName]];
    
}



- (void)btnClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewDidSelected:)]) {
        [self.delegate viewDidSelected:self.viewIdentifier];
    }
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
