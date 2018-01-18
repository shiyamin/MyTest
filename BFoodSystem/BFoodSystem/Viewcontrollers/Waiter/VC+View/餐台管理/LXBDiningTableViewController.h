//
//  LXBDiningTableViewController.h
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFBaseViewController.h"


@interface LXBDiningTableViewController :BFBaseViewController

@property (nonatomic, strong) NSArray *deskArr;

@property (nonatomic, copy) NSString *name;

- (void)hiddenTopTitleLable;



@end
