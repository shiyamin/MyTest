//
//  BFShopServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopServices.h"
#import "BFShopDetailModel.h"
#import "BFAreaModel.h"
#import "BFDeskModel.h"
#import "BFMessageModel.h"
#import "BFMessageListModel.h"


@implementation BFShopServices



/**
 获取商铺详情
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getShopDetailInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/getDetail"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dataDic = [resDic objectForKey:@"data"];
            BFShopDetailModel *model = [[BFShopDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            success(model);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"========%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
}


/**
 修改店面信息
 
 @param merchaName 商户名称
 @param merChaDesStr 商户描述
 @param shopNameStr 店面名字
 @param logoId logo
 @param addressStr 地址
 @param tel 电话
 @param avgStr 平均消费
 @param openStr 营业时间
 @param tableFee 餐位费
 @param shopDes 店面描述
 @param picIds  图片id
 @param tagStr  标签
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)postShopDetailInfoWithMerchaName:(NSString *)merchaName merchaDescripment:(NSString *)merChaDesStr shopName:(NSString *)shopNameStr logoId:(NSString *)logoId address:(NSString *)addressStr tel:(NSString *)tel personAvgPrice:(NSString *)avgStr opentime:(NSString *)openStr tableFee:(NSString *)tableFee shopDescripment:(NSString *)shopDes picIds:(NSString *)picIds tagStr:(NSString *)tagStr payType:(NSString *)payType foodType:(NSString *)foodType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    if (!picIds) {
        picIds = @"";
    }
    
    if (!logoId) {
        logoId = @"";
    }
    
    if (!payType) {
        payType = @"0";
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:shopNameStr forKey:@"shop_name"];
    [dic setObject:logoId forKey:@"logo"];
    [dic setObject:addressStr forKey:@"address"];
    [dic setObject:tel forKey:@"tel"];
    [dic setObject:tableFee forKey:@"tableFee"];
    [dic setObject:avgStr forKey:@"avgprice"];
    [dic setObject:openStr forKey:@"openTime"];
    [dic setObject:shopDes forKey:@"description"];
    [dic setObject:picIds forKey:@"pic_list"];
    [dic setObject:tagStr forKey:@"tag_list"];
    [dic setObject:foodType forKey:@"foodType"];
    [dic setObject:payType forKey:@"payType"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shop/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改店面接口====%@", responseObject);
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
 获取区域列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDeskAreaInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/deskArea/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSArray *dataArr = [resDic objectForKey:@"data"];
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                BFAreaModel *model = [[BFAreaModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSMutableArray *deskArr = [NSMutableArray array];
                for (NSDictionary *dic in model.desk_list) {
                    BFDeskModel *deskModel = [[BFDeskModel alloc] init];
                    [deskModel setValuesForKeysWithDictionary:dic];
                    [deskArr addObject:deskModel];
                }
                model.desk_list = deskArr;
                [modelArr addObject:model];
            }
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"区域列表信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);

    }];
    

}



/**
 删除区域
 
 @param areaId 区域的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectDeskAreaWithAreaId:(NSString *)areaId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:areaId forKey:@"id"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/deskArea/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除区域====%@", responseObject);
        
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
 修改区域信息
 
 @param areaId 区域id
 @param areaName 区域名字
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveAreaInfoToServicesWithAreaId:(NSString *)areaId areaName:(NSString *)areaName SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:areaId forKey:@"id"];
    [dic setObject:areaName forKey:@"name"];

//    NSString *signStr = [BFUtils getSortStrWithDic:dic andAppSecret:[BFUserSignelton shareBFUserSignelton].app_secret];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/deskArea/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改区域信息====%@", responseObject);
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
 获取餐桌列表
 
 @param deskName 餐桌的名字
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDeskListDetailWithDeskName:(NSString *)deskName SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/desk/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:deskName forKey:@"name"];

    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"获取餐桌列表===%@", responseObject);

        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSArray *resArr = [resDic objectForKey:@"data"];
            NSMutableArray *deskArr = [NSMutableArray array];
            for (NSDictionary *deskDic in resArr) {
                BFDeskModel *deskModel = [[BFDeskModel alloc] init];
                [deskModel setValuesForKeysWithDictionary:deskDic];
                [deskArr addObject:deskModel];
            }
            success(deskArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}




/**
 删除餐桌
 
 @param deskId 餐桌id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectDeskWithDeskId:(NSString *)deskId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].appKey forKey:@"app_key"];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:deskId forKey:@"id"];
    
//    NSString *signStr = [BFUtils getSortStrWithDic:dic andAppSecret:[BFUserSignelton shareBFUserSignelton].app_secret];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",BaseURL,@"/desk/delete",[BFUtils requestHeaderInfo]];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除区域====%@", responseObject);
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
 修改餐桌信息
 
 @param nameStr 餐桌名字
 @param numStr 餐桌人数
 @param areaid 区域id
 @param typeStr 类型id
 @param deskid 餐桌id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveDeskInfoWithDeskName:(NSString *)nameStr personNum:(NSString *)numStr areaId:(NSString *)areaid deskType:(NSString *)typeStr deskId:(NSString *)deskid SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:[BFUserSignelton shareBFUserSignelton].appKey forKey:@"app_key"];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:areaid forKey:@"area_id"];
    [dic setObject:nameStr forKey:@"name"];
    [dic setObject:numStr forKey:@"num"];
    [dic setObject:typeStr forKey:@"type"];
    [dic setObject:deskid forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/desk/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改餐桌信息====%@", responseObject);
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
 获取消息列表
 
 @param messageType 消息id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getMessageListInfoWithMessageType:(NSString *)messageType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/message/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:messageType forKey:@"type"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dataDic = [resDic objectForKey:@"data"];
            BFMessageModel *messageModel = [[BFMessageModel alloc] init];
            [messageModel setValuesForKeysWithDictionary:dataDic];
            
            NSArray *listDataArr = [dataDic objectForKey:@"msg_list"];
            NSMutableArray *modelArr = [NSMutableArray array];
            NSMutableArray *addArr = [NSMutableArray array];

            for (NSDictionary *dic in listDataArr) {
                BFMessageListModel *listModel = [[BFMessageListModel alloc] init];
                [listModel setValuesForKeysWithDictionary:dic];
                [modelArr addObject:listModel];
            }
//            NSArray *dataArr = [resDic objectForKey:@"data"];
//            NSMutableArray *modelArr = [NSMutableArray array];
//            for (NSDictionary *dic in dataArr) {
//                BFAreaModel *model = [[BFAreaModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                NSMutableArray *deskArr = [NSMutableArray array];
//                for (NSDictionary *dic in model.desk_list) {
//                    BFDeskModel *deskModel = [[BFDeskModel alloc] init];
//                    [deskModel setValuesForKeysWithDictionary:dic];
//                    [deskArr addObject:deskModel];
//                }
//                model.desk_list = deskArr;
            [addArr addObject:messageModel];
            [addArr addObject:modelArr];
            success(addArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"区域列表信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}

/**
 消息保存
 
 @param messageTitle 消息标题
 @param messageDescription 消息内容
 @param picList 图片列表
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */

- (void)saveMessageInfoWithMessageTitle:(NSString *)messageTitle messageDescription:(NSString *)messageDescription picList:(NSString *)picList SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/message/save"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:messageTitle forKey:@"title"];
    [dic setObject:messageDescription forKey:@"content"];
    [dic setObject:picList forKey:@"pic_list"];
    
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:URL dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"保存信息====%@", responseObject);
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
 清台
 
 @param deskId 餐桌id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)deskClearWtihDeskId:(NSString *)deskId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:deskId forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/desk/clear"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"清台====%@", responseObject);
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
 处理呼叫
 
 @param messageId 消息id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)confirmCallMessageWithMessageId:(NSString *)messageId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:messageId forKey:@"msg_id"];
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/message/confirm"];
    BFLog(@" url=%@\n dic = %@", URL, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:URL dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"处理呼叫====%@", responseObject);
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



@end
