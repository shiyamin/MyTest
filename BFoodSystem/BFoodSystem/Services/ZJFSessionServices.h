//
//  ZJFSessionServices.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFSessionServices : NSObject
+ (AFHTTPSessionManager *)sharedHTTPSession;
+ (AFURLSessionManager *) shareURLSession;
@end
