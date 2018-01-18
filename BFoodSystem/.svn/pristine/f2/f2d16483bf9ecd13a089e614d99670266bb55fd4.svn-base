//
//  NSString+Base64.m
//  NetTool
//
//  Created by 1 on 2016/10/26.
//  Copyright © 2016年 1. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)
// 编码
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

// 解码
- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}



// 字典转Json字符串
+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

// JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    if ([jsonString isKindOfClass:[NSNull class]]){
        BFLog(@"jsonString为空");
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        BFLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)convertTimestamp:(NSInteger)Timestamp showDetailFormat:(BOOL)showDetailFormat
{
    NSString *StrTimestamp = [NSString stringWithFormat:@"%ld", (long)Timestamp];
//    NSTimeInterval time=[StrTimestamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[StrTimestamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
//    DLog(@"date:%@",[detaildate description]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    if (showDetailFormat){// 显示小时,分,秒
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }else{// 显示到天
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;


}

+ (NSString *)convertTimestampStr:(NSString *)StrTimestamp showDetailFormat:(BOOL)showDetailFormat
{
//    NSTimeInterval time=[StrTimestamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[StrTimestamp doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
//    DLog(@"date:%@",[detaildate description]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    if (showDetailFormat){// 显示小时,分,秒
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }else{// 显示到天
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+ (NSString *)convertTimestampShort:(NSInteger)Timestamp
{
    NSString *StrTimestamp = [NSString stringWithFormat:@"%ld", (long)Timestamp];
//    NSTimeInterval time=[StrTimestamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[StrTimestamp doubleValue];

    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
//    DLog(@"date:%@",[detaildate description]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;

}
//获取当前时间的年月日
+ (NSInteger)convertTimestamp:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [dateFormatter dateFromString:dateStr];
    NSInteger timeTamp = [currentDate timeIntervalSince1970];
    return timeTamp;
}

//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    NSDate *newDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

//获取当前时间的时分秒
+ (NSString *)getTimeForDate{
     NSDate *newDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:newDate];
    return string;
    
}

//将时间转为数字，用来比较
+(NSInteger)changeTimeStrToNumber:(NSString *)timeStr{
    if([timeStr isEqualToString:@""]){
        return 0;
    }
    NSString *hourStr = [timeStr substringToIndex:2];
    NSString *minStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    NSString *secStr = [timeStr substringFromIndex:6];
    NSInteger timeNum = [hourStr integerValue]*3600 + [minStr integerValue]*60 + [secStr integerValue];
    return timeNum;
}

//获取当前时间戳
+(long)getCurrentTime{
       NSDate *newDate = [NSDate date];
    return (long)[newDate timeIntervalSince1970];
}


@end
