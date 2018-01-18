//
//  BFUtils.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFUtils : NSObject

+ (NSString *)deviceVersion;

+ (NSString *)requestHeaderInfo;


+ (NSString *)clientVersionCode;

+ (NSString *)nocesStr;

+ (NSString *)getSortStrWithDic:(NSMutableDictionary *)dateDic andAppSecret:(NSString *)appSecret;

//登录页
+ (void)setRootViewControllerWithLoginViewController;

//管理员首页
+ (void)setRootViewControllerWithHomeViewController;

//服务员首页
+ (void)setRootViewControllerWithWaiterViewController;

//收银员首页
+ (void)setRootViewControllerWithCashierViewController;


//显示小菊花
+ (void)showProgressHUDWithTitle:(NSString *)title
                          inView:(UIView *)superView
                        animated:(BOOL)animated;

//隐藏小菊花
+ (void)hideProgressHUDInView:(UIView *)superView
                     delegate:(id)hudDelegate
                     animated:(BOOL)animated
                   afterDelay:(NSTimeInterval)delayTime;


/**
 隐藏最上层的小菊花
 */
+ (void)hideProgressHUDInTopView;




/**
 提示框 0：自动消失；1：只有一个按钮

 @param type 提示框的样式 0：自动消失；1：只有一个按钮
 @param title 提示的标题
 @param message 提示的内容
 */
+ (void)showAlertController:(NSInteger)type title:(NSString *)title message:(NSString *)message;

/**
 *
 *
 *  @param VC
 *  @param type
 *  @param title   提示的标题
 *  @param message 提示的内容
 *
 *  @return
 */


/**
 提示框（有事件的）
 @return 返回提示框 添加事件
 */
+ (UIAlertController *)alertController:(NSString *)title message:(NSString *)message;


+ (UIViewController *)topViewController;

+ (UIImage *)cutImage:(UIImage*)image forImageViewFrame:(CGRect )imageViewFrame;

/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;

/**
 压图片质量
 
 @param image image
 @return Data
 */
+ (NSData *)zipImageWithImage:(UIImage *)image;

@end
