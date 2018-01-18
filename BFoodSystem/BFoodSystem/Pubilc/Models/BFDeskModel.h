//
//  BFDeskModel.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDeskModel : NSObject

@property (nonatomic, copy) NSString *area_id;

@property (nonatomic, copy) NSString *name;
//桌子的数量
@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *deskId;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSString *qr_code;

//使用status表示的是有人和空桌的状态
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSArray *area;

@property (nonatomic, copy) NSArray *order_list;

//是否完成 支付表示的是已支付和未支付的状态
@property (nonatomic,copy) NSString *isPay;
//用餐人数
@property (nonatomic, copy) NSString *number;
////餐具的个数;
//桌子订单创建时间
@property (nonatomic, copy) NSString *create_date;

@property (nonatomic, copy) NSString *payWait;

@property (nonatomic, copy) NSString *goodsAmount;

@property (nonatomic, copy) NSString *orderAmount;
//总的餐位费;
@property (nonatomic, copy) NSString *tableFee;
@property (nonatomic, copy) NSString *tableware;

@end
