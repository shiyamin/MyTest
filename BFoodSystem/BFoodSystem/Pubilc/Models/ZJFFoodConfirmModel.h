//
//  ZJFFoodConfirmModel.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/18.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFFoodConfirmModel : NSObject

@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *payTime;
@property (nonatomic, copy) NSString *orderAmount;
@property (nonatomic, copy) NSString *goodsAmount;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *ordtablewareerID;
@property (nonatomic, copy) NSString *deskId;
@property (nonatomic, strong) NSArray *dishesArr;

@end
