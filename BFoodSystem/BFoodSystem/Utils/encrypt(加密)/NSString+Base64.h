//
//  NSString+Base64.h
//  NetTool
//
//  Created by 1 on 2016/10/26.
//  Copyright © 2016年 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

/// 字典转Json字符串
+ (NSString*)convertToJSONData:(id)infoDict;
/// JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/// 时间轴转换
+ (NSString *)convertTimestamp:(NSInteger)Timestamp showDetailFormat:(BOOL)showDetailFormat;
/// 时间轴转换
+ (NSString *)convertTimestampStr:(NSString *)StrTimestamp showDetailFormat:(BOOL)showDetailFormat;

/// 时间轴转换
+ (NSString *)convertTimestampShort:(NSInteger)Timestamp;
//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate;
//获取当前小时的时间戳字符串
+ (NSString *)getTimeForDate;
//将时间转为数字，用来比较
+(NSInteger)changeTimeStrToNumber:(NSString *)timeStr;

/// 转化为数字时间轴
+ (NSInteger )convertTimestamp:(NSString *)dateStr;


+(long)getCurrentTime;


@end
