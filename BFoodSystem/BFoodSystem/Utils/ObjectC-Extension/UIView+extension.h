//
//  UIView+extension.h
//  DaYouSDK
//
//  Created by fanggod on 2017/3/13.
//  Copyright © 2017年 DaYou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (extension)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
//大小
@property (nonatomic, assign) CGSize  size;
//x值
@property (nonatomic, assign) CGFloat x;
//y值
@property (nonatomic, assign) CGFloat y;
//宽
@property (nonatomic, assign) CGFloat width;
//高
@property (nonatomic, assign) CGFloat height;
//中心X
@property (nonatomic, assign) CGFloat centerX;
//中心Y
@property (nonatomic, assign) CGFloat centerY;
//原点
@property (assign, nonatomic) CGPoint origin;

- (void)rotate:(NSTimeInterval)duration;
/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;
/**
 *  1.添加边框
 *
 *  @param color 颜色
 */
- (void)addBorderColor:(UIColor *)color;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)addTarget:(id)target
           action:(SEL)action;

/*
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;


/**
 *  1.添加边框
 *
 *  @param color 颜色
 */
- (void)addBorderWithColor:(UIColor *)color withRadius:(CGFloat)radius withBorderWidth:(CGFloat)width;


/**
 添加圆角

 @param corner 圆角边框所在位置      UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
 */
- (void)setCornerWithDifferentPosition:(UIRectCorner )corner;


/**
 添加分割线

 @param color 分割线颜色
 @param borderWidth 线长
 @param borderType 线所在方位
 @return 返回view
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end
