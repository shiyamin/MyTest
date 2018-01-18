//
//  UIButton+BFRedButton.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "UIButton+BFRedButton.h"

@implementation UIButton (BFRedButton)


- (void)setButtonRedStatus{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    self.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

+ (instancetype)configUniversalWithTitle:(NSString *)name
                     withNormalImageName:(NSString *)normalName
                      withHightImageName:(NSString *)hightName
                          withTitleColor:(NSString *)colorName
                             withBgImage:(NSString *)bgImgName
                             withBgColor:(NSString *) bgColorName
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:name forState:UIControlStateNormal];
    [but setTitleColor:[UIColor colorWithHex:colorName] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    if (bgImgName.length != 0) {
        
        [but setBackgroundImage:[UIImage imageNamed:bgImgName] forState:UIControlStateNormal];
    }
    if (bgColorName.length != 0) {
        
        [but setBackgroundColor:[UIColor colorWithHex:bgColorName]];
    }
    
    
    return but;
}


@end
