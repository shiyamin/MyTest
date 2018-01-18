//
//  BFWaiterHomehdView.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFWaiterHomehdViewDelegate <NSObject>

- (void)logoutAction;

@end


@interface BFWaiterHomehdView : UIView

@property (nonatomic, strong) NSString *waiteName;

@property (nonatomic, strong) NSString *waiterTime;

@property (nonatomic, assign) id <BFWaiterHomehdViewDelegate> delegate;

@end
