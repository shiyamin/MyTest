//
//  BFLoginServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFLoginServices.h"

@implementation BFLoginServices


/**
 获取短信验证码
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getSMSCodeWithPhoneNum:(NSString *)phoneNum sendType:(NSString *)type SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNum forKey:@"phone"];
    [dic setObject:type forKey:@"type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/codeSend"];

    BFLog(@"getSMS   url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
//        BFLog(@"res == %@", responseObject);
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
 用户注册接口
 
 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param codeStr 验证码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)userRegistWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr smsCode:(NSString *)codeStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userNameStr forKey:@"username"];
    [dic setObject:passwordStr forKey:@"password"];
    [dic setObject:codeStr forKey:@"code"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/register"];
    
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"注册信息====%@", responseObject);
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
 退出登录接口
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)logoutWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/logout"];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];

    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"退出登录====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            [[BFUserSignelton shareBFUserSignelton] logoutClearUserInfo];
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
 用户登录接口
 
 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)userLoginWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userNameStr forKey:@"username"];
    [dic setObject:passwordStr forKey:@"password"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/login"];
    
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"登录信息====%@", responseObject);
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
            
            
            BFUserSignelton *userInfo = [BFUserSignelton shareBFUserSignelton];
            NSDictionary *userDataDic = [dataDic objectForKey:@"data"];
            userInfo.token = [userDataDic objectForKey:@"token"];
            userInfo.printer_addr = [userDataDic objectForKey:@"printer_addr"];
            [userInfo setUserInfo:[userDataDic objectForKey:@"info"]];
            NSString *loginType = [[userDataDic objectForKey:@"info"] objectForKey:@"loginType"];
            success(loginType);
            
            //保存第一次启动的信息
            NSUserDefaults *userdefauls = [NSUserDefaults standardUserDefaults];
            [userdefauls setObject:userNameStr forKey:@"mobile"];
            [userdefauls setObject:passwordStr forKey:@"passWord"];
            [userdefauls setObject:@"YES" forKey:@"isAutoLogin"];
            [userdefauls synchronize];
            
            
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
 修改密码接口
 
 @param userNameStr 用户名
 @param passwordStr 用户密码
 @param codeStr 验证码
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)findPasswordWithUserName:(NSString *)userNameStr password:(NSString *)passwordStr smsCode:(NSString *)codeStr SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userNameStr forKey:@"username"];
    [dic setObject:passwordStr forKey:@"password"];
    [dic setObject:codeStr forKey:@"code"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/app/findPass"];
    
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改密码====%@", responseObject);
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
 获取用户信息
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getUserInfoWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
}










@end
