//
//  BFImageUploadServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFImageUploadServices.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"


@implementation BFImageUploadServices

- (void)uploadImageWithImage:(NSArray *)imageArr parame:(NSArray *)parArr completion:(void (^)(NSArray *resultArr))completionBlock{
    // 需要上传的数据
    NSArray* images = imageArr;
    
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray* result = [NSMutableArray array];
    for (int i = 0 ; i<images.count; i++) {
        [result addObject:[NSNull null]];
    }
    
    dispatch_group_t group = dispatch_group_create();
    

    for (NSInteger i = 0; i < images.count; i++) {
        PHAsset *imageAsset = parArr[i];
        dispatch_group_enter(group);

        [[TZImageManager manager] getOriginalPhotoWithAsset:imageAsset completion:^(UIImage *photo, NSDictionary *info) {
            NSString *fileStr = [NSString stringWithFormat:@"%@",[info objectForKey:@"PHImageFileURLKey"]];
            NSArray *fileArr = [fileStr componentsSeparatedByString:@"/"];
            NSString *fileName = fileArr.lastObject;
            NSURLSessionUploadTask* uploadTask = [self uploadTaskWithImage:images[i] parame:fileName completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                NSDictionary *resDic = (NSDictionary *)responseObject;
                
                if (error ) {
                    BFLog(@"第 %d 张图片上传失败", (int)i + 1);
                    dispatch_group_leave(group);
                } else {
                    if ( [[resDic objectForKey:@"code"] integerValue] != 0) {
                        BFLog(@"第 %d 张图片上传失败错误码： %@  错误信息==%@", (int)i + 1, [resDic objectForKey:@"code"],[resDic objectForKey:@"msg"]);
                    }
                    BFLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                    @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                        result[i] = responseObject;
                    }
                    dispatch_group_leave(group);
                }
                
            }];
            
            [uploadTask resume];
            
        }];
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        BFLog(@"上传完成!");
        completionBlock(result);
        for (id response in result) {
            BFLog(@"图片上传信息====%@", response);
        }
    });

    
}


- (NSURLSessionUploadTask*)uploadTaskWithImage:(UIImage*)image parame:(NSString *)fileName completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {

    NSError* error = NULL;

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    NSInteger time = [[NSDate date] timeIntervalSince1970];
    [dic setValue:[BFUtils nocesStr] forKey:@"noncestr"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)time] forKey:@"timestamp"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/store/upload"];

    BFLog(@"picUpload === %@", url);
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        UIImage *newImage = [BFUtils compressImage:image newWidth:400];
        NSData* imageData = [BFUtils zipImageWithImage:newImage];
        [formData appendPartWithFileData:imageData name:@"download" fileName:fileName mimeType:@"multipart/form-data"];
    } error:&error];
    
    
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    //配置请求头信息
    NSMutableDictionary *headerFieldValueDictionary = [NSMutableDictionary dictionary];
    NSString *signStr = [BFUtils getSortStrWithDic:dic andAppSecret:[BFUserSignelton shareBFUserSignelton].app_secret];

    [headerFieldValueDictionary setObject:signStr forKey:@"sign"];
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
    
    
    request.allHTTPHeaderFields = headerFieldValueDictionary;
    
    
    // 可在此处配置验证信息
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:completionBlock];
    
    return uploadTask;
}


@end
