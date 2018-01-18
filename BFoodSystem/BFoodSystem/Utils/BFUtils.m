//
//  BFUtils.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFUtils.h"
#import "sys/utsname.h"
#import "BFUserSignelton.h"
#import "NSString+Hash.h"
#import "AppDelegate.h"
#import "BFLoginViewController.h"
#import "BFHomeViewController.h"
#import "BFCashierController.h"
#import "BFWaiterController.h"
#import "BFBaseNavController.h"
#import <CoreImage/CoreImage.h>
#import <AssetsLibrary/AssetsLibrary.h>



#define COMMON_DATA_REQ_PROG_HUD_TAG                9998

@implementation BFUtils


+ (NSString*)deviceVersion
{

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    return deviceString;
}

+ (NSString *)requestHeaderInfo{
     NSInteger time = [[NSDate date] timeIntervalSince1970];
    NSString *nocester = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            nocester = [nocester stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            nocester = [nocester stringByAppendingString:tempString];
        }
    }

    NSString *phoneInfo = [NSString stringWithFormat:@"?noncestr=%@&timestamp=%ld",nocester,(long)time];
    return phoneInfo;
}

+ (NSString *)nocesStr{
    NSString *nocester = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            nocester = [nocester stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            nocester = [nocester stringByAppendingString:tempString];
        }
    }
    return nocester;
}

+ (NSString *)getSortStrWithDic:(NSMutableDictionary *)dateDic andAppSecret:(NSString *)appSecret{
    

    [dateDic setValue:appSecret forKey:@"app_secret"];

    NSArray *keyArray = [dateDic allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
         return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *signStr = [NSMutableString string];
//    BFLog(@"加密前的字典====%@   %@", dateDic,keyArray);
    for (int i = 0; i<sortArray.count; i ++) {
        NSString *key = sortArray[i];
        if([[NSString stringWithFormat:@"%@",[dateDic objectForKey:key]] isEqualToString:@""]){
            continue;
        }
        NSMutableString *valueStr = [NSMutableString stringWithFormat:@"%@",[dateDic objectForKey:key]];
        NSString *itemStr = [NSString stringWithFormat:@"%@=%@&",key,valueStr];
        if (i == sortArray.count -1) {
            itemStr = [NSString stringWithFormat:@"%@=%@",key,valueStr];
        }
        [signStr appendString:itemStr];
    }
    NSString *encodeStr = [NSString Sha1EncryptWithString:signStr keyString:[BFUserSignelton shareBFUserSignelton].app_secret];
    
    BFLog(@"encodeStr ===%@   sign = %@", encodeStr,signStr);
    return encodeStr;
}


//进入登录的页面
+ (void)setRootViewControllerWithLoginViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app restoreRootViewController:[[BFBaseNavController alloc] initWithRootViewController:[[BFLoginViewController alloc] init]]];
}

//首页管理
+ (void)setRootViewControllerWithHomeViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app restoreRootViewController:[[BFBaseNavController alloc] initWithRootViewController:[[BFHomeViewController alloc] init]]];

}
//进入服务员
+ (void)setRootViewControllerWithWaiterViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app restoreRootViewController:[[BFBaseNavController alloc] initWithRootViewController:[[BFWaiterController alloc] init]]];

}

//进入收银员
+ (void)setRootViewControllerWithCashierViewController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app restoreRootViewController:[[BFBaseNavController alloc] initWithRootViewController:[[BFCashierController alloc] init]]];

}


//显示小菊花
+ (void)showProgressHUDWithTitle:(NSString *)title
                          inView:(UIView *)superView
                        animated:(BOOL)animated
{
    MBProgressHUD *requestHUD = (MBProgressHUD *)[superView viewWithTag:COMMON_DATA_REQ_PROG_HUD_TAG];
    if (!requestHUD) {
        requestHUD = [[MBProgressHUD alloc] initWithView:superView];
        requestHUD.mode = MBProgressHUDModeIndeterminate;
        requestHUD.tag = COMMON_DATA_REQ_PROG_HUD_TAG;
        [superView addSubview:requestHUD];
    }
    requestHUD.hidden = NO;
    [superView bringSubviewToFront:requestHUD];
    if (!title) {
        title = @"正在加载...";
    }
    requestHUD.labelText = title;
    [requestHUD show:animated];
}

//隐藏小菊花
+ (void)hideProgressHUDInView:(UIView *)superView
                     delegate:(id)hudDelegate
                     animated:(BOOL)animated
                   afterDelay:(NSTimeInterval)delayTime
{
    MBProgressHUD *requestHUD = (MBProgressHUD *)[superView viewWithTag:COMMON_DATA_REQ_PROG_HUD_TAG];
    if (requestHUD) {
        animated = NO;
        if (hudDelegate) {
            requestHUD.delegate = hudDelegate;
            [requestHUD hide:animated afterDelay:delayTime];
        } else {
            requestHUD.hidden = YES;
        }
    }
}

+ (void)hideProgressHUDInTopView{
    [self hideProgressHUDInView:[self topViewController].view delegate:nil animated:YES afterDelay:0];
}


+ (void)showAlertController:(NSInteger)type title:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    switch (type) {
        case 0: {
            [[self getPresentedViewController] presentViewController:alert animated:YES completion:nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeAlertView:) userInfo:alert repeats:NO];
            break;
        }
        case 1:{
            UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:defult];
            [[self getPresentedViewController] presentViewController:alert animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}
+ (UIAlertController *)alertController:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [[self getPresentedViewController] presentViewController:alert animated:YES completion:nil];
    return alert;
}


// 获取当前版本的版本号
+ (NSString *)clientVersionCode
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

+ (void)removeAlertView:(NSTimer *)timer
{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;;
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}


//裁剪图片
+ (UIImage *)cutImage:(UIImage*)image forImageViewFrame:(CGRect )imageViewFrame
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (imageViewFrame.size.width / imageViewFrame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * imageViewFrame.size.height / imageViewFrame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * imageViewFrame.size.width / imageViewFrame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage *smallImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    return smallImage;
}



/**
 压图片质量
 
 @param image image
 @return Data
 */
+ (NSData *)zipImageWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = 32*1024;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
    }
    return compressedData;
}

/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}




@end
