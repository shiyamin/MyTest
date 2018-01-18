//
//  UIButton+BFRedButton.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BFRedButton)


- (void)setButtonRedStatus;


+ (instancetype)configUniversalWithTitle:(NSString *)name
                     withNormalImageName:(NSString *)normalName
                      withHightImageName:(NSString *)hightName
                          withTitleColor:(NSString *)colorName
                             withBgImage:(NSString *)bgImgName
                             withBgColor:(NSString *) bgColorName;

@end
