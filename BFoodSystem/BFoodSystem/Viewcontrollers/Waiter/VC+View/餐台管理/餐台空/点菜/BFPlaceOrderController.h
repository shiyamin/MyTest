//
//  BFPlaceOrderController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFDeskModel.h"

typedef void(^refreshTableBlock)(BOOL isAdd);


@interface BFPlaceOrderController : BFBaseViewController

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *eatNum;

@property (nonatomic, copy) refreshTableBlock refreshBlock;

@property (nonatomic, strong)BFDeskModel *deskModel;



- (void)updateTable;



@end
