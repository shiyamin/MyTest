//
//  BFAppServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFAppServices : BFBaseServices


/**
 获取appkey的接口

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 错误码回调
 */
- (void)getAppKeyWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 应用初始化

 @param token 登录令牌
 @param regisStr 推送的id
 @param ver 应用版本号
 @param uuid 设备串
 @param phone 手机型号
 @param sys 系统版本
 */
- (void)appinfoToServicesWithToken:(NSString *)token registrationId:(NSString *)regisStr ver:(NSString *)ver uuid:(NSString *)uuid phone:(NSString *)phone sys:(NSString *)sys;

@end
