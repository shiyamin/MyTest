//
//  BFAreaSelectController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFNewDeskController.h"

@interface BFAreaSelectController : BFBaseViewController


@property (nonatomic, strong)BFNewDeskController *deskVc;

- (void)updateAreaWithDataArr:(NSArray *)dataArr;



@end
