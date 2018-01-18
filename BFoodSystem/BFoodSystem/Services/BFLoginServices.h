//
//  BFLoginServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFLoginServices : BFBaseServices




/**
 获取短信验证码

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getSMSCodeWithPhoneNum:(NSString *)phoneNum sendType:(NSString *)type SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
   用户注册接口

 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param codeStr 验证码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)userRegistWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr smsCode:(NSString *)codeStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 用户登录接口
 
 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)userLoginWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;

/**
 退出登录接口

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)logoutWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 修改密码接口

 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param codeStr 验证码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)findPasswordWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr smsCode:(NSString *)codeStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取用户信息

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getUserInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




@end
