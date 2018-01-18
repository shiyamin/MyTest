//
//  AppDelegate.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController;




@end

