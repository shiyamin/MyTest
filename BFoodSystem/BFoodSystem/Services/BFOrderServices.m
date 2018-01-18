//
//  BFOrderServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFOrderServices.h"
#import "BFFoodClassModel.h"
#import "BFFoodModel.h"
#import "BFCartFoodModel.h"
#import "LXBOrder_listModel.h"
#import "LXBCookingdetailModel.h"
#import "ZJFFoodConfirmModel.h"
#import "ZJFConfirmListModel.h"
#import "BFPrintOrderModel.h"


@implementation BFOrderServices



/**
 添加到购物车
 
 @param shelfId 菜品id
 @param foodNum 菜品数量
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)cartSaveWithShelfId:(NSString *)shelfId withDeskID:(NSString *)deskId andFoodNum:(NSInteger )foodNum SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/cart/save"];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:shelfId forKey:@"shelf_id"];
    [dic setObject:deskId forKey:@"desk_id"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)foodNum] forKey:@"quantity"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;

        success(resDic);
        BFLog(@"添加到购物车===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

    
    
   
    
    
    
}



/**
 获取购物车列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getCartListWithDeskId:(NSString *)deskId WithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/cart/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setValue:deskId forKey:@"desk_id"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
//            NSArray *dishes_list = [resDic objectForKey:@"data"];
//            NSMutableArray *modelArr = [NSMutableArray array];
//            for (NSDictionary *foodic in dishes_list) {
//                    BFCartFoodModel *foodModel = [[BFCartFoodModel alloc] init];
//                    [foodModel setValuesForKeysWithDictionary:foodic];
//                    [modelArr addObject:foodModel];
//        }
//            success(modelArr);
        
//            NSArray *cartArr = [[resDic objectForKey:@"data"] objectForKey:@"cart_list"];
//            NSMutableArray *modelArr = [NSMutableArray array];
//            for (NSDictionary *dataDic in cartArr) {
//
//                for (NSDictionary *foodic in [dataDic objectForKey:@"dishes_list"]) {
//                    BFCartFoodModel *foodModel = [[BFCartFoodModel alloc] init];
//                    [foodModel setValuesForKeysWithDictionary:foodic];
//                    [modelArr addObject:foodModel];
//                }
//            }
//            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"获取购物车列表===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}

- (void)getOrderListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure
{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSArray *dataArr = [resDic objectForKey:@"data"];
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                LXBOrder_listModel *orderModel = [[LXBOrder_listModel alloc] init];
                [orderModel setValuesForKeysWithDictionary:dic];
                NSMutableArray *dishesArr = [NSMutableArray array];
                for (NSDictionary *dic in orderModel.dishes_list) {
                    LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                    [dishesModel setValuesForKeysWithDictionary:dic];
                    [dishesArr addObject:dishesModel];
                }
                NSMutableArray *cancelArr = [NSMutableArray array];
                for (NSDictionary *dic in orderModel.cancel_list) {
                    LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                    [dishesModel setValuesForKeysWithDictionary:dic];
                    [cancelArr addObject:dishesModel];
                }
                orderModel.dishes_list = dishesArr;
                orderModel.cancel_list = cancelArr;
                [modelArr addObject:orderModel];
            }
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
//        BFLog(@"区域列表信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}




/**
 订单提交
 
 @param deskId 餐桌id
 @param numStr 用餐人数
 @param remarkInfo 备注信息
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveOrderWithDeskId:(NSString *)deskId eatNum:(NSString *)numStr remarkInfo:(NSString *)remarkInfo SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:deskId forKey:@"desk_id"];
    [dic setObject:numStr forKey:@"number"];
    [dic setObject:remarkInfo forKey:@"remark"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"订单提交====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *orderDic = [dataDic objectForKey:@"data"];
            
            success([orderDic objectForKey:@"orderSn"]);
        }else{
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 订单详情
 
 @param orderId 订单id
 @param userId  用户id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)orderListWithOrderId:(NSString *)orderId userId:(NSString *)userId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:orderId forKey:@"id"];
    [dic setObject:userId forKey:@"user_id"];

//    NSLog(@"%@",dic);
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/getDetail"];
    [BFYBaseNetTool getRequest:url requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dataDic = [resDic objectForKey:@"data"];
            NSMutableArray *modelArr = [NSMutableArray array];
            ZJFFoodConfirmModel *orderModel = [[ZJFFoodConfirmModel alloc] init];
            [orderModel setValuesForKeysWithDictionary:dataDic];
            NSMutableArray *dishesArr = [NSMutableArray array];
                for (NSDictionary *dic in orderModel.dishesArr) {
                    ZJFConfirmListModel *dishesModel = [[ZJFConfirmListModel alloc] init];
                    [dishesModel setValuesForKeysWithDictionary:dic];
                    [dishesArr addObject:dishesModel];
                }
                orderModel.dishesArr = dishesArr;
                [modelArr addObject:orderModel];
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"订单详情信息===%@", responseObject);

    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 订单确认
 
 @param messageId 信息Id
 @param status    状态
 @param success   成功回调
 @param errCode   错误信息回调
 @param failure   失败回调
 */
- (void)confirmWithMessageId:(NSString *)messageId status:(NSString *)status SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:messageId forKey:@"msg_id"];
    [dic setObject:status forKey:@"status"];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/confirm"];
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:URL dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
//        BFLog(@"菜单确认====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success(@"YES");
        }else{
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

    

    
}


/**
 支付
 @param orderId 订单id
 @param paytype 支付方式
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)orderPaymentWayWithOrderId:(NSString *)orderId payType:(NSString *)paytype SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
//    [dic setObject:orderId forKey:@"order_id"];
    [dic setObject:paytype forKey:@"payType"];
    [dic setObject:orderId forKey:@"desk_id"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/pay"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"选择支付方式====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success(@"YES");
        }else{
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 修改用餐信息
 
 @param orderId 订单id
 @param number 用餐人数
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)changeOrderInfoWithOrderId:(NSString *)orderId dinnerNumber:(NSString *)number SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:orderId forKey:@"order_id"];
    [dic setObject:number forKey:@"number"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/saveDiner"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改用餐信息====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success(@"YES");
        }else{
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}




/**
 清空购物车
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)clearCartOrderListSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/cart/clear"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"清空购物车====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success(@"YES");
        }else{
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



/**
 根据订单id查询需要打印的信息
 
 @param orderId 订单id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getPrintInfoWithOrderId:(NSString *)orderId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:orderId forKey:@"out_trade_no"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/getDetailByOutTradeNo"];
    BFLog(@" url=%@\n dic = %@", url, dic);

    [BFYBaseNetTool getRequest:url requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSDictionary *dataDic = resDic[@"data"];
        BFPrintOrderModel *printModel = [[BFPrintOrderModel alloc] init];
        printModel.deskDic = dataDic[@"desk"];
        [printModel setValuesForKeysWithDictionary:dataDic];
        for (NSDictionary *dishDic  in dataDic[@"dishes_list"]) {
            LXBCookingdetailModel *foodModel = [[LXBCookingdetailModel alloc] init];
            [foodModel setValuesForKeysWithDictionary:dishDic];
            [printModel.dishesArr addObject:foodModel];
        }
        
        success(printModel);
        
        BFLog(@"打印的订单详情===%@", responseObject);
 
    } failure:^(NSError *error) {
        failure(error);
    }];

}



/**
 催菜接口
 
 @param num 桌号
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)reminderMenuWithTableNum:(NSString *)num printIp:(NSString *)ipStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://%@/Home/AddReminderMenu?tableNum='%@'",ipStr,num];
    
    manager.requestSerializer = requestSerializer;
    BFLog(@"requestURL==%@", url);

    [manager GET:url parameters:@{} progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        BFLog(@"催菜返回信息==%@", responseObject);

       success(@"YES");

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        
        !failure ? : failure (error);
    }];

}



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
- (void)printOrderTableNum:(NSString *)tableNum printIp:(NSString *)ipStr waiterName:(NSString *)nameStr orderNum:(NSString *)orderNum time:(NSString *)timeStr personNum:(NSString *)personNum orderDetail:(NSArray *)foodArr coupons:(NSString *)money remark:(NSString *)remark SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:foodArr options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:tableNum forKey:@"tableNum"];
    [dic setObject:nameStr forKey:@"operatorName"];
    [dic setObject:orderNum forKey:@"orderNum"];
    [dic setObject:timeStr forKey:@"date"];
    [dic setObject:personNum forKey:@"num"];
    [dic setObject:jsonString forKey:@"details"];
    [dic setObject:money forKey:@"coupons"];
    [dic setObject:remark forKey:@"remark"];
    
    NSString *url = [NSString stringWithFormat:@"http://%@/Home/AddOrder",ipStr];
    BFLog(@" jsonStringurl= %@\n dic = %@", url, dic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSData *date = responseObject;
        NSString *res =  [[NSString alloc]initWithData:date encoding:NSUTF8StringEncoding];
         BFLog(@"打印接口====%@ ",res );
        
        success(@"YES");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        BFLog(@"打印接口====%@ ", error);
        
    }];



}




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
- (void)passMenuWithTableNum:(NSString *)tableNum printIp:(NSString *)ipStr time:(NSString *)timeStr orderNum:(NSString *)orderNum passOrderArr:(NSArray *)foodArr remark:(NSString *)remark SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:foodArr options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:tableNum forKey:@"tableNum"];
    [dic setObject:orderNum forKey:@"orderNum"];
    [dic setObject:timeStr forKey:@"date"];
    [dic setObject:jsonString forKey:@"passMenuDetail"];
    [dic setObject:remark forKey:@"remark"];
    
    NSString *url = [NSString stringWithFormat:@"http://%@/Home/AddPassMenu",ipStr];
    BFLog(@" jsonStringurl= %@\n dic = %@", url, dic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSData *date = responseObject;
        NSString *res =  [[NSString alloc]initWithData:date encoding:NSUTF8StringEncoding];
        BFLog(@"传菜接口====%@ ",res );
        
        success(@"YES");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        BFLog(@"传菜接口====%@ ", error);
        
    }];

}



@end
