//
//  Utils.m
//  DKPlatform
//
//  Created by 程智锋 on 15/9/22.
//  Copyright © 2015年 程智锋. All rights reserved.
//

#import "Utils.h"

@implementation Utils


//trim字符串两头的空白字符
NSString *trim(NSString *dirtyString)
{
    NSString *cleanString = [dirtyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}

//检查字符串是否为空
BOOL isStringEmpty(NSString *string)
{
    if (string != nil && string != (id)[NSNull null] && string.length > 0 ) {
        return NO;
    }
    return YES;
}

//根据文本计算高度
CGFloat calculateAttributedTextHeightForWidth(NSAttributedString *text, CGFloat textWidth)
{
    if (text.length > 0) {
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        return ceilf(textRect.size.height);
//                if (runTimeOSVersion >= 7.0999) {
//                    return ceilf(textRect.size.height);
//                } else {
//                    return ceilf(textRect.size.height) + ceil(text.size.width/textWidth)*3.0;//修复iOS7.0高度计算不能正常处理行距的问题
//                }
    } else {
        return 0.0;
    }
}

//根据文本计算宽度
CGFloat calculateAttributedTextWidthForHeight(NSAttributedString *text, CGFloat textHeight)
{
    if (text.length > 0) {
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, textHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
        return ceilf(textRect.size.width);
    } else {
        return 0.0;
    }
}


//从网址中截取域名
NSString *getDomainFromURLString(NSString *url)
{
    NSRange rangeHeader = [url rangeOfString:@"://"];
    if (rangeHeader.location != NSNotFound) {
        url = [url substringFromIndex:(rangeHeader.location+rangeHeader.length)];
    }
    NSRange rangePort = [url rangeOfString:@":"];
    if (rangePort.location != NSNotFound) {
        url = [url substringToIndex:rangePort.location];
    }
    NSRange rangeTail = [url rangeOfString:@"/"];
    if (rangeTail.location != NSNotFound) {
        url = [url substringToIndex:rangeTail.location];
    }
    return url;
}

//获取系统版本号
NSString *getOSVersion()
{
    NSString *version = [UIDevice currentDevice].systemVersion ;//判定系统版本
    return version;
}


//获取设备名称
NSString *getDeviceName(){
    NSString *strName = [[UIDevice currentDevice] name];
    return strName;
}


//获取手机名称
NSString *getIphoneName(){
    NSString *phoneName = [[UIDevice currentDevice] model];
    return phoneName;
}

//获取手机的UUID
//NSString *getIphoneUUID(){
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef string = CFUUIDCreateString(NULL, uuid);
//    CFRelease(uuid);
//    return (__bridge NSString *)string;
//    
//}



//获取手机的UUID
NSString *getIphoneUUID()
{
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [udf objectForKey:@"UUIDString"];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        [udf setObject:uuid forKey:@"UUIDString"];
        [udf synchronize];
    }
    return uuid;
    
}


//根据颜色生成图像
UIImage *imageFromColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//根据颜色生成图像，带size参数
UIImage *imageFromColorWithSize(UIColor *color, CGSize size)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//获取格式化的日期，自动截取，如传参20150101，如果不使用年则返回1月1日
NSString *getFormatDateStr(NSString *dateStr,BOOL useYear)
{
    if (dateStr.length<8) {
        return nil;
    }
    dateStr = [dateStr substringToIndex:8];
    NSString *year = [dateStr substringToIndex:4];
    NSString *month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [dateStr substringWithRange:NSMakeRange(6, 2)];
    NSString *result = @"";
    if (useYear) {
        result = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    }else{
        result = [NSString stringWithFormat:@"%@月%@日",month,day];
    }
    return result;
}


//获取格式化的日期，自动截取，如传参20150101
NSString *getFormatDatePointStr(NSString *dateStr)
{
    if (dateStr.length<8) {
        return nil;
    }
    dateStr = [dateStr substringToIndex:8];
    NSString *year = [dateStr substringToIndex:4];
    NSString *month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [dateStr substringWithRange:NSMakeRange(6, 2)];
    NSString *result = @"";
    result = [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
    return result;
}

// 获取格式化的时间，如传20151022020823，返回2015-10-22 09：08
NSString *getFormatTimeStr(NSString *timeStr){
    if (timeStr.length<12) {
        return nil;
    }
    timeStr = [timeStr substringToIndex:12];
    NSString *year   = [timeStr substringToIndex:4];
    NSString *month  = [timeStr substringWithRange:NSMakeRange(4, 2)];
    NSString *day    = [timeStr substringWithRange:NSMakeRange(6, 2)];
    NSString *hour   = [timeStr substringWithRange:NSMakeRange(8, 2)];
    NSString *minute = [timeStr substringWithRange:NSMakeRange(10, 2)];
    NSString *result = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
    return result;
}

// 获取格式化的时间，如传20151022020823，返回2015-10-22 09：08
NSString *getFormatNoSecondTimeStr(NSString *timeStr){
    if (timeStr.length<8) {
        return nil;
    }
    timeStr = [timeStr substringToIndex:8];
    NSString *year   = [timeStr substringToIndex:4];
    NSString *month  = [timeStr substringWithRange:NSMakeRange(4, 2)];
    NSString *day    = [timeStr substringWithRange:NSMakeRange(6, 2)];
    NSString *result = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    return result;
}

//屏幕截图的方法
UIImage *capture()
{
    UIGraphicsBeginImageContextWithOptions([UIApplication sharedApplication].keyWindow.bounds.size, NO, 0.0);
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
