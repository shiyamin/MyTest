//
//  BFRightBtn.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/29.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BFRightBtn : UIButton


- (void)setRightBtnTitle:(NSString *)titleStr andTarget:(UIViewController *)target clickAction:(SEL )action;

@end
