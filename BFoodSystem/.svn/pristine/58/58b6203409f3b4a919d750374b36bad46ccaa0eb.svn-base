//
//  UIImage+BFScaledImage.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/12.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "UIImage+BFScaledImage.h"

@implementation UIImage (BFScaledImage)

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image forImageView:(UIImageView *)imageView
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (imageView.frame.size.width / imageView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * imageView.frame.size.height / imageView.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * imageView.frame.size.width / imageView.frame.size.height;
        
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
       
    }
    UIImage *smallImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
//    return [UIImage imageWithCGImage:imageRef];
    return smallImage;

}




@end
