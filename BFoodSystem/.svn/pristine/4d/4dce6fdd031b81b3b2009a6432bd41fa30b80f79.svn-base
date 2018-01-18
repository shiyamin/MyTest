//
//  BFWaiterSetController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/23.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFEmployeeModel.h"

typedef enum : NSUInteger {
    waiterSetTypeAddWaiter,
    waiterSetTypeSetWaiter,
    waiterSetTypeAddCashier,
    waiterSetTypeSetCashier,
} WaiterSetType;

@class BFWaiterMangerController;

@interface BFWaiterSetController : BFBaseViewController

@property (nonatomic, assign) WaiterSetType vcType;

@property (nonatomic, strong) BFEmployeeModel *employeeMdoel;

@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, strong) BFWaiterMangerController *waiterMangerVc;

@end
