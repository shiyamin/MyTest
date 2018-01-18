//
//  BFUserServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFUserServices : BFBaseServices


/**
 删除员工

 @param employeeId 员工id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectEmployeeWithEmployeeId:(NSString *)employeeId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取员工列表

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getEmployeeListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 修改员工信息

 @param nickName 员工昵称
 @param employeeName 员工姓名
 @param password 密码
 @param typeStr 员工类型
 @param headId 头像id
 @param employeeId 员工id
 @param areaIds 区域id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveEmployeeInfoWithNickName:(NSString *)nickName employeeName:(NSString *)employeeName password:(NSString *)password loginType:(NSString *)typeStr headimgId:(NSString *)headId employeeId:(NSString *)employeeId areaIds:(NSString *)areaIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 获取个人详情
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */

- (void)getPersonDetailInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;

/**
 修改个人信息
 
 @param headImg 个人头像
 @param userNickname 昵称
 @param userSex      性别
 @param trueName     真实姓名
 @param password     密码
 @param oldPassword  旧密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */

- (void)saveUserInfoWithHeadimg:(NSString *)headImg userNickname:(NSString *)userNickname trueName:(NSString *)trueName userSex:(NSString *)userSex password:(NSString *)password  oldPassword:(NSString *)oldPassword SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



@end
