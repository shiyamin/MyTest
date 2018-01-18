//
//  BFYBaseNetTool.h
//  NetInterFaceTool
//
//  Created by 1 on 2016/10/27.
//  Copyright © 2016年 1. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BFYBaseNetTool : NSObject

// 创建单例
+ (BFYBaseNetTool *)defaultNetworking;
/**
 *  发送一个POST请求
 *
 *  @param path     请求路径
 *  @param param  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)post:(NSString *)path params:(NSDictionary *)param progress:(void (^)( NSProgress *Progress)) Progress success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  带有request的post请求
 *
 *  @param request  需要设置body
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)postRequest:(NSMutableURLRequest *)request params:(NSMutableDictionary *)param success:(void (^)(id responseObject, NSURLResponse * response))success failure:(void (^)(NSError * error))failure;


/**
 get通用请求

 @param url 请求的url
 @param requstDic 请求的参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getRequest:(NSString *)url requestDic:(NSMutableDictionary *)requstDic success:(void (^)(id responseObject, NSURLResponse *response))success failure:(void (^)(NSError *error))failure;

+ (NSMutableURLRequest *)dealRequset:(NSString *)path dataDic:(NSMutableDictionary *)dataDic;



@end
