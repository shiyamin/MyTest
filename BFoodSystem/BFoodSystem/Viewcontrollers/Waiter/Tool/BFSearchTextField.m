//
//  BFSearchTextField.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFSearchTextField.h"

@implementation BFSearchTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)searchBarWithTitle:(NSString *)title withImage:(NSString *)imgName
{
    BFSearchTextField *fieldView = [[BFSearchTextField alloc] init];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    imgView.frame = CGRectMake(10, 8, 15, 15);
//    fieldView.leftView = imgView;
    fieldView.placeholder = title;
    fieldView.borderStyle = UITextBorderStyleRoundedRect;
    fieldView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_L19].CGColor;
    fieldView.layer.cornerRadius = 4.0;
    fieldView.layer.masksToBounds = YES;
    fieldView.font = [UIFont systemFontOfSize:14];
    [fieldView addSubview:imgView];
    return fieldView;
    
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
    
}
//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
}

@end
