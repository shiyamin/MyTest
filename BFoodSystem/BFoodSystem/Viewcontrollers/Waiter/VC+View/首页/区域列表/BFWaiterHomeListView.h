//
//  BFWaiterHomeListView.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFWaiterController.h"

@interface BFWaiterHomeListView : UIView

@property (nonatomic, weak) BFWaiterController *waiterVC;

- (void)loadData;


@end
