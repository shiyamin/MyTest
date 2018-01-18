//
//  BFQueryServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFQueryServices : BFBaseServices



/**
 获取菜品销售统计

 @param startStr 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsDishesWithStartTime:(NSString *)startStr endTime:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取收入统计
 
 @param startStr 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsDailyWithStartTime:(NSString *)startStr endTime:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;






/**
 删除银行卡
 
 @param bankid  银行卡id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectBankCardWithBankId:(NSString *)bankid SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取银行卡列表

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getBankCardListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 修改银行卡信息

 @param bankNum 银行卡号
 @param imageId 图片id
 @param cardholder 持卡人
 @param bankName 银行名字
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveBankInfoWithBankNum:(NSString *)bankNum bankImageId:(NSString *)imageId personName:(NSString *)cardholder bankName:(NSString *)bankName SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 检查是否设置支付密码

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)checkIsSetPayPasswordSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 设置提现密码

 @param passStr 新的密码
 @param oldPassStr 旧密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)setPayPasswordWtihNewPassword:(NSString *)passStr oldPass:(NSString *)oldPassStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 验证支付密码

 @param psdStr 密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)verifyPayPasswordWith:(NSString *)psdStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 余额提现

 @param pasStr 密码
 @param amountStr 金额
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)withdrawMoneyWithPassword:(NSString *)pasStr withAmount:(NSString *)amountStr payModel:(NSString *)model SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 菜品撤销日志
 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getOrderCancelLogWtihWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 获取提现日志

 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getUserAccountWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 年度/月流水查询

 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode  错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsMonthWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 更新统计信息

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)updateStatusInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




@end
