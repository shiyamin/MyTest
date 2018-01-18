//
//  LXBDishes_listModel.h
//  BFoodSystem
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXBCookingdetailModel : NSObject

@property (nonatomic, copy) NSString *dishesID;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *sku_id;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *pic_list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSArray *pic_url;
@property (nonatomic, copy) NSString *dishes_id;

@property (nonatomic, assign) CGFloat cellHeight;



@end
