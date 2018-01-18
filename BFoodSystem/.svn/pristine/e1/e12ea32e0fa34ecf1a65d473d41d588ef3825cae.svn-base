//
//  BFOrderServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseServices.h"

@interface BFOrderServices : BFBaseServices



/**
 添加到购物车

 @param shelfId 菜品id
 @param foodNum 菜品数量
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)cartSaveWithShelfId:(NSString *)shelfId withDeskID:(NSString *)deskId andFoodNum:(NSInteger )foodNum SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取购物车列表

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getCartListWithDeskId:(NSString *)deskId WithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 获取订单列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getOrderListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;







/**
 订单提交

 @param deskId 餐桌id
 @param numStr 用餐人数
 @param remarkInfo 备注信息
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveOrderWithDeskId:(NSString *)deskId eatNum:(NSString *)numStr remarkInfo:(NSString *)remarkInfo SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;

/**
 订单详情
 
 @param orderId 订单id
 @param userId  用户id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */

- (void)orderListWithOrderId:(NSString *)orderId userId:(NSString *)userId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;

/**
 订单确认
 
 @param messageId 信息Id
 @param status    状态
 @param success   成功回调
 @param errCode   错误信息回调
 @param failure   失败回调
 */
- (void)confirmWithMessageId:(NSString *)messageId status:(NSString *)status SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;

/**
 支付

 @param orderId 订单id
 @param paytype 支付方式
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)orderPaymentWayWithOrderId:(NSString *)orderId payType:(NSString *)paytype SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;





/**
 修改用餐信息

 @param orderId 订单id
 @param number  用餐人数
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)changeOrderInfoWithOrderId:(NSString *)orderId dinnerNumber:(NSString *)number SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;





/**
 清空购物车

 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)clearCartOrderListSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 根据订单id查询需要打印的信息

 @param orderId 订单id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getPrintInfoWithOrderId:(NSString *)orderId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;


/**
 催菜接口

 @param num 桌号
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)reminderMenuWithTableNum:(NSString *)num printIp:(NSString *)ipStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;



/**
 打印订单接口

 @param tableNum 餐桌号
 @param nameStr 服务员名字
 @param orderNum 订单号
 @param timeStr 时间
 @param personNum 就餐人数
 @param foodArr 订单菜品详情
 @param money 优惠金额
 @param remark 备注
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)printOrderTableNum:(NSString *)tableNum printIp:(NSString *)ipStr waiterName:(NSString *)nameStr orderNum:(NSString *)orderNum time:(NSString *)timeStr personNum:(NSString *)personNum orderDetail:(NSArray *)foodArr coupons:(NSString *)money remark:(NSString *)remark SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;




/**
 传菜接口

 @param tableNum 桌号
 @param timeStr 时间
 @param orderNum 订单号
 @param foodArr 菜品数据
 @param remark 备注
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)passMenuWithTableNum:(NSString *)tableNum printIp:(NSString *)ipStr time:(NSString *)timeStr orderNum:(NSString *)orderNum passOrderArr:(NSArray *)foodArr remark:(NSString *)remark SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure;





@end
