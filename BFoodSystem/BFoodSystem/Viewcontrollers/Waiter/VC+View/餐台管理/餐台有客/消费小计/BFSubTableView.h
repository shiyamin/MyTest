//
//  BFSubTableView.h
//  BFoodSystem
//
//  Created by binbin on 2017/4/26.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBCookingdetailModel.h"
@interface BFSubTableView : UITableView


@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic, assign) CGFloat goodsAmount;

@property (nonatomic, strong) LXBCookingdetailModel *cookingModel;
@end


@interface LXBConsumptionFooterView :UITableViewHeaderFooterView
+ (instancetype)footerInitailize:(UITableView *)tableView;

@property (nonatomic, strong) UILabel *totalMoneyLabel;//总价格
@property (nonatomic,assign)CGFloat totalMoney;
@end



@interface LXBExpensedHeader : UITableViewHeaderFooterView
//注册会在该方法内容做的 所以外部不需要注册的
+ (instancetype)headerInitialize:(UITableView *)tableView;
- (void)setTestDataFunction:(NSString *)imagName title:(NSString *)title withTitleColor:(NSString *)titleColor;
@end
