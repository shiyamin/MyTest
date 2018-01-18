//
//  ZJFConfirmListModel.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/18.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFConfirmListModel : NSObject

@property (nonatomic, copy) NSString *dishesID;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *skuId;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picList;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) NSArray *picUrlArr;

@end
