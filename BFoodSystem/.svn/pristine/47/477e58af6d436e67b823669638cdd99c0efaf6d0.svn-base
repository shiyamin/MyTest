//
//  BFRightBtn.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/29.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFRightBtn.h"

@interface BFRightBtn ()



@end

@implementation BFRightBtn


- (instancetype)init{
    if (self = [super init]) {
        [self setStatus];
    }
    return self;
}




- (void)setStatus{
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
    self.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self setTitleColor:[UIColor colorWithHex:BF_COLOR_B1] forState:UIControlStateNormal];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
    [self setFrame:CGRectMake(0, 0, 60, 30)];

}

- (void)setRightBtnTitle:(NSString *)titleStr andTarget:(UIViewController *)target clickAction:(SEL )action{
    
    [self setTitle:titleStr forState:UIControlStateNormal];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
