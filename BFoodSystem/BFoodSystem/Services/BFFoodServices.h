//
//  BFFoodServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFFoodServices : BFBaseServices



/**
 删除菜品分类

 @param typeId 菜品分类的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectDishesTypeWithTypeId:(NSString *)typeId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取菜品分类信息

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDishesListWtihSaleStatus:(NSString *)saleType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 修改或保存菜品分类信息

 @param nameStr 分类名称
 @param levelStr 等级
 @param dishesId 分类id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveDishesInfoWithName:(NSString *)nameStr sortLevel:(NSString *)levelStr dishesId:(NSString *)dishesId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;






/**
 删除菜品接口

 @param foodId 菜品的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectFoodWithFoodId:(NSString *)foodId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取菜品详细信息

 @param foodId 菜品的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getFoodDetailWithFoodId:(NSString *)foodId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 获取菜品列表

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDishLishWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 保存修改菜品信息

 @param foodName 菜品名字
 @param foodDes 菜品描述
 @param foodPrice 菜品价格
 @param foodId 菜品的id
 @param typeIds 菜品分类ids
 @param picLists 菜品图片ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveFoodInfoWithFoodName:(NSString *)foodName foodDescription:(NSString *)foodDes foodPrice:(NSString *)foodPrice foodId:(NSString *)foodId typeIds:(NSString *)typeIds picLists:(NSString *)picLists SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 批量下架菜品

 @param foodIds 菜品的ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectManyFoodWithFoodIds:(NSString *)foodIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 批量上架菜品

 @param foodIds 菜品的ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveManyFoodOnSaleWithFoodIds:(NSString *)foodIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取上架菜品列表

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getOnSaleListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;





@end
