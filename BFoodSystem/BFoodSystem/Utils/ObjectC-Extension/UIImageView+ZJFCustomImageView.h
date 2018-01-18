//
//  UIImageView+ZJFCustomImageView.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJFCustomImageView)

+ (instancetype)showNonDateImageWithAddView: (UIView *)view;

- (void)showBadgeOnItmIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;


@end
