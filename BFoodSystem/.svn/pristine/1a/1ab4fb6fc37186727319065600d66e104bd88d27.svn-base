//
//  BFInfoNumView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFInfoNumView.h"

@implementation BFInfoNumView


- (instancetype)init{
    if (self = [super init]) {
        [self creatSubviews];
    }
    return self;
}


- (void)creatSubviews{
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.titleLable.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    [self addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);
    }];
    
    self.numLable = [[UILabel alloc] init];
    self.numLable.textAlignment = NSTextAlignmentCenter;
    self.numLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.numLable.textColor = [UIColor colorWithHex:BF_COLOR_B11];
    self.numLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.numLable];
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.5);

    }];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
