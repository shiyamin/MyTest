//
//  BFFoodSaleModel.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BFFoodModel.h"

@interface BFFoodSaleModel : NSObject


@property (nonatomic, strong) BFFoodModel *foodModel;

@property (nonatomic, copy) NSString *dishes_id;

@property (nonatomic, copy) NSString *shelf_id;

@property (nonatomic, copy) NSString *sku_id;



@end
