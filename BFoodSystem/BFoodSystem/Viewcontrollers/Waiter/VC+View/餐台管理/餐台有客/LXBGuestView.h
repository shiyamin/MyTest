//
//  LXBGuestView.h
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBGuestViewController.h"


@interface LXBGuestView : UIView

//数据源
@property(nonatomic,copy)NSArray * dataArray;
@property (nonatomic,strong) NSDictionary *messageDic;
@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, weak) LXBGuestViewController *LxbVc;


@end
