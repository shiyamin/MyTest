//
//  BFDeskAreaServices.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/7.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFDeskAreaServices : BFBaseServices



/**
 获取区域餐桌信息和餐桌列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDeskAreaWtihSaleStatus:(NSString *)saleType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 获取区域中餐桌的详情列表
 
 @param deskId 桌子的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDeskDetailWithDeskId:(NSString *)deskId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


- (void)revokedDishesReportWithParameter:(NSDictionary *)parameter SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;
@end
