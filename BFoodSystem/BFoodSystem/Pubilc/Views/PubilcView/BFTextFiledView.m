//
//  BFTextFiledView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTextFiledView.h"

@interface BFTextFiledView ()



@end

@implementation BFTextFiledView


- (instancetype)init{
    if (self = [super init]) {
        [self setStatusForSubViews];
    }
    return self;
}

- (void)setStatusForSubViews{
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    self.clipsToBounds = YES;
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    self.textfiled = [[UITextField alloc] init];
    self.textfiled.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.textfiled.borderStyle = UITextBorderStyleNone;
    [self addSubview:self.textfiled];
    [self.textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(5);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)configImage:(NSString *)imageStr textfiledPlaceholder:(NSString *)textplaceholder{
    [self.imageView setImage:[UIImage imageNamed:imageStr]];
    self.textfiled.placeholder = textplaceholder;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
