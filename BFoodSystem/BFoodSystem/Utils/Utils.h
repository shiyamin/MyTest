//
//  Utils.h
//  DKPlatform
//
//  常用的方法集合，不涉及任何的业务和逻辑
//
//  Created by 程智锋 on 15/9/22.
//  Copyright © 2015年 程智锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

//trim字符串两头的空白字符
NSString *trim(NSString *dirtyString);

//检查字符串是否为空
BOOL isStringEmpty(NSString *string);


//根据文本计算高度
CGFloat calculateAttributedTextHeightForWidth(NSAttributedString *text, CGFloat textWidth);

//根据文本计算宽度
CGFloat calculateAttributedTextWidthForHeight(NSAttributedString *text, CGFloat textHeight);

//从网址中截取域名
NSString *getDomainFromURLString(NSString *url);


//获取系统版本号
NSString *getOSVersion();

//获取设备名称
NSString *getDeviceName();

//获取手机名称
NSString *getIphoneName();

//获取手机的UUID
NSString *getIphoneUUID();

//根据颜色生成图像
UIImage *imageFromColor(UIColor *color);

//根据颜色生成图像,带size参数
UIImage *imageFromColorWithSize(UIColor *color, CGSize size);

//获取格式化的日期，自动截取，超出则报错，如传参20150101，如果不使用年则返回1月1日
NSString *getFormatDateStr(NSString *dateStr,BOOL useYear);

//获取格式化的日期，自动截取，超出则报错，如传参20150101，返回 2015.05.08
NSString *getFormatDatePointStr(NSString *dateStr);

// 获取格式化的时间，如传20151022020823，返回2015-10-22 09：08 
NSString *getFormatTimeStr(NSString *timeStr);

// 获取格式化的时间，如传20151022020823，返回2015-10-22
NSString *getFormatNoSecondTimeStr(NSString *timeStr);

//屏幕截图的方法
UIImage *capture();

@end
