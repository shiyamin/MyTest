//
//  ZJFUpTagController.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/12.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"


typedef void (^ReturnTagArrBlock)(NSArray *showTagArr);

@interface ZJFUpTagController : BFBaseViewController

@property (assign, nonatomic)NSInteger allowUploadNum;

@property (nonatomic, copy) ReturnTagArrBlock returnTagArrBlock;

- (void)returnTag:(ReturnTagArrBlock)block;


@end
