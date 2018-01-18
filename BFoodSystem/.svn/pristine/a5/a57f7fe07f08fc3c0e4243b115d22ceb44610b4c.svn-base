//
//  BFQueryServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryServices.h"
#import "BFQueryFoodModel.h"
#import "BFQueryDailyModel.h"
#import "BFBankModel.h"
#import "BFUserAmountModel.h"
#import "BFRevokedMdoel.h"

@implementation BFQueryServices


/**
 获取菜品销售统计
 
 @param startStr 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsDishesWithStartTime:(NSString *)startStr endTime:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/statistics/dishes"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:startStr forKey:@"start"];
    [dic setObject:endTime forKey:@"end"];

    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSMutableArray *foodModelArr = [NSMutableArray array];
        for (NSDictionary *foodDic in [resDic objectForKey:@"data"]) {
            BFQueryFoodModel *model = [[BFQueryFoodModel alloc] init];
            [model setValuesForKeysWithDictionary:foodDic];
            [foodModelArr addObject:model];
        }
        success(foodModelArr);
        BFLog(@"获取菜品销售统计===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}


/**
 获取收入统计
 
 @param startStr 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsDailyWithStartTime:(NSString *)startStr endTime:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/statistics/daily"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:startStr forKey:@"start"];
    [dic setObject:endTime forKey:@"end"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *dataDic in [resDic objectForKey:@"data"]) {
            BFQueryDailyModel *model = [[BFQueryDailyModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [modelArr addObject:model];
        }
        success(modelArr);
        BFLog(@"获取收入统计===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

    
    
}


/**
 删除银行卡
 
 @param bankid  银行卡id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectBankCardWithBankId:(NSString *)bankid SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:bankid forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/bank/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除区域====%@", responseObject);
        
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            
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
 获取银行卡列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getBankCardListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/bank/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modeArr = [NSMutableArray array];
            for (NSDictionary *modelDic in [resDic objectForKey:@"data"]) {
                BFBankModel *bankModel = [[BFBankModel alloc] init];
                [bankModel setValuesForKeysWithDictionary:modelDic];
                [modeArr addObject:bankModel];
            }
            success(modeArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"银行卡列表信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}




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
- (void)saveBankInfoWithBankNum:(NSString *)bankNum bankImageId:(NSString *)imageId personName:(NSString *)cardholder bankName:(NSString *)bankName SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:bankNum forKey:@"number"];
    [dic setObject:imageId forKey:@"image"];
    [dic setObject:cardholder forKey:@"cardholder"];
    [dic setObject:bankName forKey:@"bankName"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/bank/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改银行卡信息====%@", responseObject);
        
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
 检查是否设置支付密码
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)checkIsSetPayPasswordSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/isSetPass"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"检查是否设置支付密码====%@", responseObject);
        
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *resultDic = [dataDic objectForKey:@"data"];
            success([resultDic objectForKey:@"isSet"]);
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
 设置提现密码
 
 @param passStr 新的密码
 @param oldPassStr 旧密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)setPayPasswordWtihNewPassword:(NSString *)passStr oldPass:(NSString *)oldPassStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:passStr forKey:@"password"];
    [dic setObject:oldPassStr forKey:@"oldpassword"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/setPass"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"设置支付密码====%@", responseObject);
        
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
 验证支付密码
 
 @param psdStr 密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)verifyPayPasswordWith:(NSString *)psdStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:psdStr forKey:@"password"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/verifyPass"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"验证支付密码====%@", responseObject);
        
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success([dataDic objectForKey:@"data"]);
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
 余额提现
 
 @param pasStr 密码
 @param amountStr 金额
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)withdrawMoneyWithPassword:(NSString *)pasStr withAmount:(NSString *)amountStr payModel:(NSString *)model SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:pasStr forKey:@"password"];
    [dic setObject:amountStr forKey:@"amount"];
    [dic setObject:model forKey:@"mode"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/withdraw"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"验证支付密码====%@", responseObject);
        
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
 菜品撤销日志
 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getOrderCancelLogWtihWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/getOrderCancelLog"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:startTime forKey:@"start"];
    [dic setObject:endTime forKey:@"end"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modeArr = [NSMutableArray array];
            for (NSDictionary *modelDic in [resDic objectForKey:@"data"]) {
                BFRevokedMdoel *revokedModel = [[BFRevokedMdoel alloc] init];
                [revokedModel setValuesForKeysWithDictionary:modelDic];
                [modeArr addObject:revokedModel];
            }
            success(modeArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"菜品撤销信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}



/**
 获取提现日志
 
 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getUserAccountWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/getAccountLog"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:startTime forKey:@"start"];
    [dic setObject:endTime forKey:@"end"];
    
    BFLog(@" url=%@\n dic = %@", URL, dic);

    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modeArr = [NSMutableArray array];
            for (NSDictionary *modelDic in [resDic objectForKey:@"data"]) {
                BFUserAmountModel *accountModel = [[BFUserAmountModel alloc] init];
                [accountModel setValuesForKeysWithDictionary:modelDic];
                [modeArr addObject:accountModel];
            }
            success(modeArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"提现日志信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}


/**
 年度/月流水查询
 
 @param startTime 开始时间
 @param endTime 结束时间
 @param success 成功回调
 @param errCode  错误信息回调
 @param failure 失败回调
 */
- (void)queryStatisticsMonthWithStratTime:(NSString *)startTime endTimeStr:(NSString *)endTime SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/statistics/month"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:startTime forKey:@"start"];
    [dic setObject:endTime forKey:@"end"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *resDic = (NSDictionary *)responseObject;
            BFQueryDailyModel *model = [[BFQueryDailyModel alloc] init];
            [model setValuesForKeysWithDictionary:[resDic objectForKey:@"data"]];
            success(model);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"获取收入统计===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




/**
 更新统计信息
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)updateStatusInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/statistics/update"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];

    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {

            success(@"yes");
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"更新统计信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}



@end
