//
//  BFUserSignelton.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFUserSignelton : NSObject

+ (instancetype)shareBFUserSignelton;


@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *app_secret;



@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *printer_addr;

@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *loginType;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *truename;

@property (nonatomic, copy) NSString *merchant_name;

//已付和未付的状态
@property (nonatomic, copy) NSString *isPay;


@property (nonatomic, assign)BOOL isPushConfirmVc;

- (void)setUserInfo:(NSDictionary *)userDic;


- (void)logoutClearUserInfo;


@end
