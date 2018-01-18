//
//  BFUserSignelton.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFUserSignelton.h"


static BFUserSignelton *_instance;

@implementation BFUserSignelton

+ (instancetype)shareBFUserSignelton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;

}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil){
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}



- (NSString *)appKey{
    
//   NSString *appkey = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_key"];
//    if (!appkey) {
//        appkey = @"";
//    }
//    BFLog(@"app_key==  %@", appkey);
    return @"SOYBoEkG";
}


- (NSString *)app_secret{
//    NSString *appSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_secret"];
//    if (!appSecret) {
//        appSecret = @"";
//    }
//    BFLog(@"app_secret == %@", appSecret);
    return @"784f6cc7330a742d86d91a70c27c0594";
}


- (void)setUserInfo:(NSDictionary *)userDic{
    _instance.headimgurl = [userDic objectForKey:@"headimgurl"];
    _instance.userId = [userDic objectForKey:@"id"];
    _instance.loginType = [userDic objectForKey:@"loginType"];
    _instance.mobile = [userDic objectForKey:@"mobile"];
    _instance.nickname = [userDic objectForKey:@"nickname"];
    _instance.truename = [userDic objectForKey:@"truename"];
    _instance.merchant_name = [userDic objectForKey:@"merchant_name"];

}

- (void)logoutClearUserInfo{
    _instance.headimgurl = @"";
    _instance.userId = @"";
    _instance.loginType = @"1";
    _instance.mobile = @"";
    _instance.nickname = @"";
    _instance.truename = @"";
    
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:@"no" forKey:@"isAutoLogin"];
    [udf setObject:@"" forKey:@"mobile"];
    [udf setObject:@"" forKey:@"passWord"];
    if([udf synchronize]){
        [BFUtils setRootViewControllerWithLoginViewController];
    }
    
}


@end
