//
//  BFQueryBaseController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFDataSearchView.h"
#import "BFQueryServices.h"


@interface BFQueryBaseController : BFBaseViewController

@property (nonatomic, strong) UITableView *tabbleView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) BFDataSearchView *dataView;

- (void)addSubviews;

- (void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr;



@end
