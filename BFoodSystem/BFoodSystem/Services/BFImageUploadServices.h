//
//  BFImageUploadServices.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFImageUploadServices : NSObject


/**
 图片上传的入口

 @param imageArr 图片数组
 @param parArr 图片信息字典
 @param completionBlock 完成回调
 */
- (void)uploadImageWithImage:(NSArray *)imageArr parame:(NSArray *)parArr completion:(void (^)(NSArray *resultArr))completionBlock;



@end
