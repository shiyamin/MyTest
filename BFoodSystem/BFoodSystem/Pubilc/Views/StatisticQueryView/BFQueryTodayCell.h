//
//  BFQueryTodayCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFQueryDailyModel.h"

#define BFQueryTodayCellIdentifier   @"BFQueryTodayCellIdentifier"
#define BFQueryTodayCellHeight       210

@interface BFQueryTodayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dataLable;

@property (weak, nonatomic) IBOutlet UILabel *orderLable;

@property (weak, nonatomic) IBOutlet UILabel *personNumLable;

@property (weak, nonatomic) IBOutlet UILabel *personMoneyLable;

@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLable;

@property (weak, nonatomic) IBOutlet UILabel *totalMonyLable;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;




@property (weak, nonatomic) IBOutlet UILabel *incomeTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *platformLabel; //平台

@property (weak, nonatomic) IBOutlet UILabel *cashierLable;//现金

@property (weak, nonatomic) IBOutlet UILabel *wechatLable;//微信

@property (weak, nonatomic) IBOutlet UILabel *payLable;//支付宝

@property (weak, nonatomic) IBOutlet UILabel *bankLable;//银行卡

@property (weak, nonatomic) IBOutlet UILabel *menberLable;//会员

@property (weak, nonatomic) IBOutlet UILabel *groupBuyLable;//美团


- (void)configCellWithDailyModel:(BFQueryDailyModel *)model;



- (void)setBackgroundIamge:(NSString *)imageName;




@end
