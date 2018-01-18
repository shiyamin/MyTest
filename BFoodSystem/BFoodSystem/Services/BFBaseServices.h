//
//  BFBaseServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BFYBaseNetTool.h"
#import "NSString+Hash.h"

typedef void(^RequestSuccessBlock)(id result);
typedef void(^RequestErrorCodeBlock)(NSInteger errorCode, NSString *errorMessage);
typedef void(^RequestFailureBlock)(NSError *error);

@interface BFBaseServices : NSObject








@end
