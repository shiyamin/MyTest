//
//  ZJFSessionServices.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFSessionServices.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZJFSessionServices

static AFHTTPSessionManager *manager = nil;
static AFURLSessionManager *urlsession = nil;

+ (AFHTTPSessionManager *)sharedHTTPSession {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      manager = [AFHTTPSessionManager manager];
        
    });
    return manager;
}

+ (AFURLSessionManager *)shareURLSession {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:
                       [NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}

@end
