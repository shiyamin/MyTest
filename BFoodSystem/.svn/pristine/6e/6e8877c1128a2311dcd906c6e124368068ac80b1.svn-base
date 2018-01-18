//
//  LXBDidOrderTableViewCell.h
//  01 点餐页面
//
//  Created by binbin on 2017/4/10.
//  Copyright © 2017年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXBCookingdetailModel.h"

@class LXBShowCart;

typedef void(^editButtonAction)(NSString * dishesID);

@interface LXBDidOrderTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger LXBCarTableCellType;//购物车的cell的风格 0为只有图片和标题 价格 1为数量的选择器 2为上下架


@property (nonatomic, strong) LXBShowCart *showCart;

@property (nonatomic, strong) LXBCookingdetailModel *dishesModel;
- (void)setUIChangeFunction;


@end



//显示数量
@interface LXBShowNumber:UIView
@property (nonatomic, strong) UILabel *numLabel;
@end
//显示是否显示购物车
@interface LXBShowCart:UIView
@property (nonatomic, strong) LXBCookingdetailModel *dishesModel;
@property(nonatomic,copy)editButtonAction editButtonAction;

@end

//撤销备注信息
@interface LXBShowRemark : UIView
@property (nonatomic, strong)UILabel *remarkLabel;
@end
