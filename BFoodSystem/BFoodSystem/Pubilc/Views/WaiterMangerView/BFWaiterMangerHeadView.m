//
//  BFWaiterMangerHeadView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterMangerHeadView.h"

@interface BFWaiterMangerHeadView ()

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, strong) UILabel *lable;

@end

@implementation BFWaiterMangerHeadView

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
    }
    return _imageview;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
    }
    return _backImageView;
}

- (UILabel *)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
    }
    return _lable;
}

- (instancetype)init{
    if (self = [super init]) {
        [self creatSubviews];
    }
    return self;
}


- (void)creatSubviews{
    [self addSubview:self.imageview];
    [self addSubview:self.backImageView];
    [self addSubview:self.lable];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(20);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
}



- (void)configBackgroundView:(NSString *)backImageName imageview:(NSString *)imageName titileInfo:(NSString *)titleStr{
    [self.backImageView setImage:[UIImage imageNamed:backImageName]];
    [self.imageview setImage:[UIImage imageNamed:imageName]];
    self.lable.text = titleStr;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
