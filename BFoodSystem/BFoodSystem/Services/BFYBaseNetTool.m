//
//  BFYBaseNetTool.m
//  NetInterFaceTool
//
//  Created by 1 on 2016/10/27.
//  Copyright © 2016年 1. All rights reserved.
//

#import "BFYBaseNetTool.h"
#import <AFNetworking/AFNetworking.h>
#import "ZJFSessionServices.h"
#import "ReachabilityUtil.h"
#import "NSString+Hash.h"



@interface BFYBaseNetTool()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (strong,nonatomic) Reachability *conn;

@end
static BFYBaseNetTool *_networking;
static AFURLSessionManager *_mgr;


@implementation BFYBaseNetTool

// 创建单例
+ (BFYBaseNetTool *)defaultNetworking
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _networking = [[BFYBaseNetTool alloc] init];
    });
    
    return _networking;
}

- (instancetype)init
{
    if (self = [super init]) {
        
//        self.manager = [AFHTTPSessionManager manager];
//        self.manager.securityPolicy.allowInvalidCertificates = YES;
//        //   去掉响应头的智能转换
//        [self.manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        self.manager = [ZJFSessionServices sharedHTTPSession];
        
        [self addobserNetworkStatus];
    }
    return self;
}

- (void)addobserNetworkStatus
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    
}
//判断网络状态
- (void)networkStateChange
{
    if ([ReachabilityUtil isConnectToNet]){// 有网络
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkStatusChangedNotification object:nil];
    }else{// 无网络

    }
}


//get请求
+ (void)getRequest:(NSString *)url requestDic:(NSMutableDictionary *)requstDic success:(void (^)(id , NSURLResponse *))success failure:(void (^)(NSError *))failure
{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [ZJFSessionServices sharedHTTPSession];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    //配置请求头信息
    NSMutableDictionary *headerFieldValueDictionary = [NSMutableDictionary dictionary];
    
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    [requstDic setValue:[BFUtils nocesStr] forKey:@"noncestr"];
    [requstDic setValue:[NSString stringWithFormat:@"%ld",(long)time] forKey:@"timestamp"];
    
    NSString *signalStr = [BFUtils getSortStrWithDic:requstDic andAppSecret:[BFUserSignelton shareBFUserSignelton].app_secret];
    
    [headerFieldValueDictionary setObject:signalStr forKey:@"sign"];
    [headerFieldValueDictionary setObject:[BFUserSignelton shareBFUserSignelton].appKey forKey:@"app_key"];
    [headerFieldValueDictionary setObject:getOSVersion() forKey:@"ver"];
    [headerFieldValueDictionary setObject:getIphoneUUID() forKey:@"uuid"];
    [headerFieldValueDictionary setObject:[BFUtils deviceVersion] forKey:@"phone"];
    [headerFieldValueDictionary setObject:getOSVersion() forKey:@"sys"];
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    manager.requestSerializer = requestSerializer;
    [manager GET:url parameters:requstDic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        BFLog(@"requestURL==%@", url);
        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
            NSDictionary *dicData = (NSDictionary *)responseObject;
            NSInteger errorCode = [[dicData objectForKey:@"code"] integerValue];
            if (errorCode < 4000) {
                if (errorCode == 2005 || errorCode == 1012) {
                    [BFUtils hideProgressHUDInTopView];
                    NSString *errorStr = [dicData objectForKey:@"msg"];
                    UIAlertController * alert = [BFUtils alertController:nil message:errorStr];
                    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[BFUserSignelton shareBFUserSignelton] logoutClearUserInfo];
                    }];
                    [confirm setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
                    [alert addAction:confirm];
                }else{
                    !success ? : success(responseObject, nil);
                }
                
            }else{
                !success ? : success(responseObject, nil);
            }
        }
        

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        
        !failure ? : failure (error);
    }];
    
}

//POST请求
- (void)post:(NSString *)path params:(NSDictionary *)param progress:(void (^)(NSProgress *))Progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
        // 替换链接
    
//        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *mgr =  [ZJFSessionServices sharedHTTPSession];
        [mgr POST:path parameters:param progress:^(NSProgress *uploadProgress) {
            !Progress ? : Progress(uploadProgress);
        } success:^(NSURLSessionDataTask * task, id responseObject) {
 
            !success ? : success(responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError *error) {
            !failure ? : failure (error);
        }];
}

+ (void)postRequest:(NSMutableURLRequest *)request params:(NSMutableDictionary *)param success:(void (^)(id , NSURLResponse *))success failure:(void (^)(NSError *))failure
{


//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
//    _mgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    _mgr = [ZJFSessionServices shareURLSession];
    
    NSURLSessionDataTask *dataTask = [_mgr dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            !failure ? : failure(error);
        }else{
//            BFLog(@"baseResponseObject==%@", responseObject);
            if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
                NSDictionary *dicData = (NSDictionary *)responseObject;
                NSInteger errorCode = [[dicData objectForKey:@"code"] integerValue];
                if (errorCode < 4000) {
                    if (errorCode == 2005) {
                        [BFUtils hideProgressHUDInTopView];
                        NSString *errorStr = [dicData objectForKey:@"msg"];
                        UIAlertController * alert = [BFUtils alertController:nil message:errorStr];
                        UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [[BFUserSignelton shareBFUserSignelton] logoutClearUserInfo];
                        }];
                        [confirm setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
                        [alert addAction:confirm];

                    }else{
                        !success ? : success(responseObject, response);
                    }
                    
                }else{
                    !success ? : success(responseObject, response);
                }
            }else{
                !failure ? : failure(error);
            }

        }
    }];
    [dataTask resume];
    
}


+ (NSMutableURLRequest *)dealRequset:(NSString *)path dataDic:(NSMutableDictionary *)dataDic
{
    
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    //配置请求头信息
    NSMutableDictionary *headerFieldValueDictionary = [NSMutableDictionary dictionary];
    
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    [dataDic setValue:[BFUtils nocesStr] forKey:@"noncestr"];
    [dataDic setValue:[NSString stringWithFormat:@"%ld",(long)time] forKey:@"timestamp"];
    
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:path parameters:dataDic error:nil];
    request.timeoutInterval = 20;
    request.HTTPMethod = @"POST";
    
    NSString *signalStr = [BFUtils getSortStrWithDic:dataDic andAppSecret:[BFUserSignelton shareBFUserSignelton].app_secret];
    [headerFieldValueDictionary setObject:signalStr forKey:@"sign"];
    [headerFieldValueDictionary setObject:[BFUserSignelton shareBFUserSignelton].appKey forKey:@"app_key"];
    [headerFieldValueDictionary setObject:getOSVersion() forKey:@"ver"];
    [headerFieldValueDictionary setObject:getIphoneUUID() forKey:@"uuid"];
    [headerFieldValueDictionary setObject:[BFUtils deviceVersion] forKey:@"phone"];
    [headerFieldValueDictionary setObject:getOSVersion() forKey:@"sys"];
    [headerFieldValueDictionary setObject: @"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }

    request.allHTTPHeaderFields = headerFieldValueDictionary;

    BFLog(@"request====%@，  body==%@", request,body);
    return request;
    
}



//使用https
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"AppApi.gdguojian.net" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[NSSet setWithObject:certData]];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}







@end
