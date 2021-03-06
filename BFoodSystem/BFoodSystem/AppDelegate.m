//
//  AppDelegate.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "AppDelegate.h"
#import "BFAppServices.h"
#import "LXBComfirmOrderViewController.h"
#import "BFWaiterController.h"
#import "BFShopServices.h"
#import <AudioToolbox/AudioToolbox.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"

// iOS10注册APNs所需头文件
#import <UserNotifications/UserNotifications.h>
#import "BFPrintManger.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()<JPUSHRegisterDelegate,BuglyDelegate> {

    NSDictionary *pushDic;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//设置根试图
    [BFUtils setRootViewControllerWithLoginViewController];
  
    //键盘设置
    [IQKeyboardManager sharedManager].enable = YES;
    [self performSelector:@selector(sendNotification:) withObject:launchOptions afterDelay:0];
    pushDic = [NSDictionary dictionary];
    
    
    //配置极光信息
    [self configJpush:(NSDictionary *)launchOptions];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    
    [self setupBugly];
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];


    
    return YES;
}

#pragma mark - bugly
- (void)setupBugly {
    BuglyConfig * config = [[BuglyConfig alloc] init];
#if DEBUG
    config.debugMode = YES;
#endif
    config.reportLogLevel = BuglyLogLevelWarn;
    config.blockMonitorEnable = YES;  //开启卡顿监控
    config.blockMonitorTimeout = 1.5; //卡顿时间
    config.channel = @"Bugly";
    config.delegate = self;
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    [Bugly setUserValue:[[UIDevice currentDevice] systemName] forKey:@"systemName"];
    [Bugly setUserValue:[[UIDevice currentDevice] systemVersion] forKey:@"systemVersion"];
    
    [Bugly startWithAppId:@""
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
}


- (void)sendNotification:(NSDictionary *)launchOptions {

    if (launchOptions) { // 不是空 就是推送点击 否则是图标启动
       
        NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //[UIDevice currentDevice].systemVersion floatValue] < 10.0 &&
        if (remoteNotification) {
        // iOS 10 不必走此方法
        [self reciveNotification:remoteNotification];// 处理推送跳转方法 详见下方
        }
    }

}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)configJpush:(NSDictionary *)launchOptions{

    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"46bc1d3d83618d6fb4cc232b"
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
         BFLog(@"regist =%@", registrationID);
        NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
        [udf setObject:registrationID forKey:@"jpush"];
        [udf synchronize];
        [self getAppKeyRequest];
    }];

    
}





#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {

    NSDictionary * userInfo = notification.request.content.userInfo;


    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // iOS10 处理远程推送
        [JPUSHService handleRemoteNotification:userInfo];
        // 前台出弹窗提示
        [self reciveNotification:userInfo];
    }else {
        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
       
    }
    completionHandler(UNNotificationPresentationOptionAlert
                      | UNNotificationPresentationOptionSound
                      | UNNotificationPresentationOptionBadge);

}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
  
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self reciveNotification:userInfo];
    } else {
        // 本地通知处理
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
//    SystemSoundID soundID;
//       NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"call" ofType:@"caf"];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
//     AudioServicesPlayAlertSound(soundID);
//     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
  
    if (application.applicationState == UIApplicationStateActive) {
        // 如果是前台运行出现弹窗
        // 前台收到推送出现弹窗
        [self reciveNotification:userInfo];
        
    }else{
        // 处于后台 的点击
        [self reciveNotification:userInfo];
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
//    int badge = [userInfo[@"aps"][@"badge"] intValue];
//    badge++;
//    [JPUSHService setBadge:badge];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


// 前台收到推送出现弹窗
- (void)reciveNotification:(NSDictionary *)pushdic{
    
    NSDictionary *extras = [pushdic objectForKey:@"extras"];
    NSString *content = [pushdic objectForKey:@"content"];
    NSString *messageID = [extras objectForKey:@"msg_id"];
    if (extras != nil || extras != NULL) {
          // 呼叫消息处理
        if ([content rangeOfString:@"呼叫"].location != NSNotFound) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:content preferredStyle:UIAlertControllerStyleAlert];
            UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            aW.rootViewController = [[UIViewController alloc]init];
            aW.windowLevel = UIWindowLevelAlert + 1;
            [aW makeKeyAndVisible];
            [aW.rootViewController presentViewController:alert animated:YES completion:nil];
          
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[BFShopServices alloc] confirmCallMessageWithMessageId: messageID SuccessBlock:^(id result) {
                    [BFUtils hideProgressHUDInView:aW delegate:self animated:YES afterDelay:0];
                    [BFUtils alertController:nil message:@"信息发送成功"];
                    if (![aW.rootViewController isBeingDismissed]) {
                        [aW.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    }

                } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils hideProgressHUDInView:aW delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];
                    if (![aW.rootViewController isBeingDismissed]) {
                        [aW.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    }

                } Failure:^(NSError *error) {
                    [BFUtils hideProgressHUDInView:aW delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                    if (![aW.rootViewController isBeingDismissed]) {
                        [aW.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                }]];
            
        } else { // 点餐消息处理
//            LXBComfirmOrderViewController *orderVC = [[LXBComfirmOrderViewController alloc] init];
//            orderVC.notificationDic = pushDic;
//            [[self currentViewController].navigationController pushViewController:orderVC animated:YES];
//            NSString *orderId = [extras objectForKey:@"out_trade_no"];
//            NSString *printerIp = [extras objectForKey:@"printer_addr"];
//            [[BFPrintManger alloc] printMessageWithOrderId:orderId printIp:printerIp success:^(NSString *result) {
//                
//            } failue:^(NSString *errorStr) {
//                
//            }];
        }
    }
}

#pragma mark 获取当前的停留的VC用来实现任意页面跳转到指定页面
- (UIViewController *)currentViewController{
    UIViewController *currVC =nil;
    UIViewController *Rootvc =self.window.rootViewController;
    do{
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)Rootvc;
            UIViewController *v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if ([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabvc = (UITabBarController *)Rootvc;
            currVC = tabvc;
            Rootvc = [tabvc.viewControllers objectAtIndex:tabvc.selectedIndex];
            continue;
        }
        
    }while (Rootvc !=nil);
    return currVC;
}


- (void)getAppKeyRequest{
    
   NSString *regisID = [[NSUserDefaults standardUserDefaults] objectForKey:@"jpush"];
   [[BFAppServices alloc] appinfoToServicesWithToken:@"" registrationId:regisID ver:[BFUtils clientVersionCode] uuid:getIphoneUUID() phone:getDeviceName() sys:getOSVersion()];
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    NSDictionary *extras = [userInfo objectForKey:@"extras"];
//    NSString *type = [extras objectForKey:@"type"];
//    
//    if (extras != nil || extras != NULL) {
//        // 呼叫消息处理
//        NSString *content = [userInfo objectForKey:@"content"];
//        NSString *messageID = [extras objectForKey:@"msg_id"];
//        if ([type integerValue] == 1) { // 点餐消息处理
//            NSString *orderId = [extras objectForKey:@"out_trade_no"];
//            NSString *printerIp = [extras objectForKey:@"printer_addr"];
//            [[BFPrintManger alloc] printMessageWithOrderId:orderId printIp:printerIp success:^(NSString *result) {
//                
//            } failue:^(NSString *errorStr) {
//                
//            }];
//        }
//    }
}


//淡入淡出更换rootViewcontroller
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}


@end
