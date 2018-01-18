//
//  BFAppServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAppServices.h"

@implementation BFAppServices

/**
 获取appkey的接口
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 错误码回调
 */
- (void)getAppKeyWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@?%@=%@",BaseURL,@"/app/key",@"platform",@"ios"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dateDic = [resDic objectForKey:@"data"];
            BFUserSignelton *useSignel = [BFUserSignelton shareBFUserSignelton];
            BFLog(@"RRRR===%@", useSignel.appKey);
            NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
            [udf setObject:[dateDic objectForKey:@"app_key"] forKey:@"app_key"];
            [udf setObject:[dateDic objectForKey:@"app_secret"] forKey:@"app_secret"];
            [udf synchronize];
        }
        BFLog(@"========%@", responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
    

}

/**
 应用初始化
 
 @param token 登录令牌
 @param regisStr 推送的id
 @param ver 应用版本号
 @param uuid 设备串
 @param phone 手机型号
 @param sys 系统版本
 */
- (void)appinfoToServicesWithToken:(NSString *)token registrationId:(NSString *)regisStr ver:(NSString *)ver uuid:(NSString *)uuid phone:(NSString *)phone sys:(NSString *)sys{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (!token || [token isEqualToString:@""]) {
        token = @"";
    }
    [dic setObject:token forKey:@"token"];
    if ([regisStr isEqualToString:@""] || !regisStr) {
        regisStr = @"";
    }
    [dic setObject:regisStr forKey:@"registration_id"];
    [dic setObject:ver forKey:@"ver"];
    [dic setObject:uuid forKey:@"uuid"];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:sys forKey:@"sys"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/init"];
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"init====%@", responseObject);

        
    } failure:^(NSError *error) {

    }];

    
    
}

















@end
