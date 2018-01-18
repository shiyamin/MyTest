//
//  BFUserServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFUserServices.h"
#import "BFEmployeeModel.h"
#import "BFAreaModel.h"
#import "BFUserInfoModel.h"


@implementation BFUserServices

/**
 删除员工
 
 @param employeeId 员工id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectEmployeeWithEmployeeId:(NSString *)employeeId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:employeeId forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/employee/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除员工====%@", responseObject);
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
 获取员工列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getEmployeeListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/employee/getList"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        BFLog(@"========%@", responseObject);

        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dic = [resDic objectForKey:@"data"];
            NSArray *dataArr  = [dic objectForKey:@"list"];
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dataDic in dataArr) {
                BFEmployeeModel *model = [[BFEmployeeModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [modelArr addObject:model];
            }
            NSArray *areaArr = [dic objectForKey:@"area_list"];
            NSMutableArray *areaModelArr = [NSMutableArray array];
            for (NSDictionary *areaDic in areaArr) {
                BFAreaModel *areaModel = [[BFAreaModel alloc] init];
                [areaModel setValuesForKeysWithDictionary:areaDic];
                [areaModelArr addObject:areaModel];
            }
            NSArray *totalArr = [NSArray arrayWithObjects:modelArr,areaModelArr, nil];
            success(totalArr);
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
- (void)saveEmployeeInfoWithNickName:(NSString *)nickName employeeName:(NSString *)employeeName password:(NSString *)password loginType:(NSString *)typeStr headimgId:(NSString *)headId employeeId:(NSString *)employeeId areaIds:(NSString *)areaIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:nickName forKey:@"nickname"];
    [dic setObject:employeeName forKey:@"truename"];
    [dic setObject:password forKey:@"password"];
    [dic setObject:typeStr forKey:@"loginType"];
    [dic setObject:headId forKey:@"headimg"];
    [dic setObject:employeeId forKey:@"id"];
    [dic setObject:areaIds forKey:@"area_ids"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/employee/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"保存员工信息====%@", responseObject);
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
 获取个人详情
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */

- (void)getPersonDetailInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/user/getInfo"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dataDic = [resDic objectForKey:@"data"];
            BFUserInfoModel *model = [[BFUserInfoModel alloc] init];
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

- (void)saveUserInfoWithHeadimg:(NSString *)headImg userNickname:(NSString *)userNickname trueName:(NSString *)trueName userSex:(NSString *)userSex password:(NSString *)password  oldPassword:(NSString *)oldPassword SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:headImg forKey:@"headimg"];
    [dic setObject:userNickname forKey:@"nickname"];
    [dic setObject:userSex forKey:@"sex"];
    [dic setObject:trueName forKey:@"truename"];
    [dic setObject:password forKey:@"password"];
    [dic setObject:oldPassword forKey:@"oldpassword"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/user/setInfo"];
    BFLog(@"url==%@\n,dic = %@", url,dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"保存个人信息===%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            success(@"YES");
        } else {
            NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [dataDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}








@end
