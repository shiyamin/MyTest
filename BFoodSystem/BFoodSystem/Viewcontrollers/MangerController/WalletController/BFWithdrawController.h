//
//  BFWithdrawController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFShopDetailModel.h"

@interface BFWithdrawController : BFBaseViewController

@property (nonatomic, strong) BFShopDetailModel *shopModel;


- (void)getBankCardInfoList;



@end
