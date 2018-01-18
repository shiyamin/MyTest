//
//  BFBaseViewController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFBaseViewController : UIViewController


- (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

- (void)back;





@end
