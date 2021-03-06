//
//  GeneralDefine.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef GeneralDefine_h
#define GeneralDefine_h


#define SINGLETON_FOR_SERVICE(serviceName)\
static serviceName *_instance;\
+(instancetype)getService\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[serviceName alloc] init];\
});\
return _instance;\
}



#if DEBUG
#ifndef BFLog
#define BFLog(format, args...) \
NSLog(@"[%s %d]: " format "\n", strrchr(__FILE__, '/') + 1, __LINE__, ## args);
#endif
#else
#ifndef BFLog
#define BFLog(format, args...) do {} while(0)
#endif
#endif


// ******测试环境的URL*****///////
//#define BaseURL @"http://dcan.ssssapp.com/store.php"
#define BaseURL @"http://www.vip-sq.com/store.php"

#define webURL   @"http://www.vip-sq.com/store.php"


///////////////////////////////////////////// 正式环境//////////////////////////////////////////////////


/********本地存储***********/
#define UserDefults [NSUserDefaults standardUserDefaults]

//**对iOS11的适配进行的宏定义**/
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


#pragma mark  --- 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NavBarHeight (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)


/********快速weakself***********/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

/******判断第一次登陆相关宏********/
#define isFirstLoad ([[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"] == nil?YES:NO)
#define isChangeUpgradeGuidePage ([[[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"] isEqualToString:[BFUtils clientVersionCode]]?NO:YES)
#define isShowGuidePage YES

/********字符串判断宏************/
#define SNVL(x)                     NSSTRING_NVL(x, @"")
#define NSSTRING_NVL(x, y)          (((x).length > 0) ? (x) : (y))

#define StringValue(s) ([s isKindOfClass:[NSNull class]] || [s isEqual:[NSNull null]] || s == nil)?@"":s

/**********代理宏***************/
#define APP_DELEGATE                (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define KEY_WINDOW                  [[UIApplication sharedApplication] keyWindow]



/**********屏幕尺寸*************/
#define SCREEN_WIDTH   (WIDTH_SCREEN > HEIGHT_SCREEN ? HEIGHT_SCREEN : WIDTH_SCREEN)
#define SCREEN_HEIGHT  (WIDTH_SCREEN > HEIGHT_SCREEN ? WIDTH_SCREEN : HEIGHT_SCREEN)
#define WIDTH_SCREEN ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT_SCREEN ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define KNavBarHeight 64



/*********系统信息*************/
//判断设备类型
#define IS_IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPhone6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPhone6plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)


/*******颜色表******/

static NSString * const BF_COLOR_B0 = @"#ffffff";
static NSString * const BF_COLOR_B1 = @"#f5f5f5";
static NSString * const BF_COLOR_B2 = @"#aeaeae";
static NSString * const BF_COLOR_B3 = @"#808080";
static NSString * const BF_COLOR_B4 = @"#3c3e48";
static NSString * const BF_COLOR_B5 = @"#1a1a1a";
static NSString * const BF_COLOR_B6 = @"#000000";

//******
static NSString * const BF_COLOR_B10 = @"#e55c25";
static NSString * const BF_COLOR_B11 = @"#e30211";
static NSString * const BF_COLOR_B12 = @"#fa3a70";
static NSString * const BF_COLOR_B13 = @"#ac35ea";
static NSString * const BF_COLOR_B14 = @"#67d3a9";
static NSString * const BF_COLOR_B15 = @"#26c98a";
static NSString * const BF_COLOR_B16 = @"#9a89ff";
static NSString * const BF_COLOR_B17 = @"#67d3a9";



#pragma mark - WaiterHome
//浅灰色
static NSString * const BF_COLOR_L16 = @"e6e6e6";
//退出的橙红色
static NSString * const BF_COLOR_L17 = @"#FF4500";
//colletionView 的颜色
static NSString * const BF_COLOR_L18 = @"#58d4eb";
//灰色的字体和灰色的线条(深灰色)  -- 线条的设置
static NSString * const BF_COLOR_L19 = @"#aeaeae";
//粉红色(无人)
static NSString * const BF_COLOR_L20 = @"#FF69B4";
//绿色(有人)
static NSString * const BF_COLOR_L21 = @"#3CB371";
//*深灰色
static NSString * const BF_COLOR_L22 = @"808080";
//红色
static NSString * const BF_COLOR_L23 = @"ff0000";
//浅浅灰色
static NSString * const BF_COLOR_L25 = @"f5f5f5";
//有客
static NSString * const BF_COLOR_L26 = @"fe709c";
//无客
static NSString * const BF_COLOR_L27 = @"67d3a9";
/*******字体大小表******/
static CGFloat BF_FONTSIZE_a0  = 10.0f;
static CGFloat BF_FONTSIZE_a1  = 12.0f;
static CGFloat BF_FONTSIZE_B1  = 13.0f;
static CGFloat BF_FONTSIZE_a2  = 14.0f;
static CGFloat BF_FONTSIZE_a3  = 16.0f;
static CGFloat BF_FONTSIZE_a4  = 18.0f;
static CGFloat BF_FONTSIZE_a5  = 20.0f;
static CGFloat BF_FONTSIZE_a6  = 48.0f;

static CGFloat BF_FONTSIZE_L7 = 15.0f;
/*******常用宏的定义************/
#define kNetworkStatusChangedNotification   @"kNetworkStatusChangedNotification"
#define updateFoodListNotification          @"updateFoodListNotification"
#define updateWaiterDeskNotification        @"updateWaiterDeskNotification"
#define kCallMessageNotification            @"kCallMessageNotification"

#endif /* GeneralDefine_h */
