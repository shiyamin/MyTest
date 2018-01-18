//
//  BFFoodModel.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/29.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFFoodModel : NSObject


@property (nonatomic, copy) NSString *foodId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *foodDescription;

@property (nonatomic, copy) NSString *pic_list;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) NSMutableArray *typeArr;

@property (nonatomic, strong) NSMutableArray *pic_url;

@property (nonatomic, copy) NSString *is_shelf;

@property (nonatomic, copy) NSString *shelf_id;

@property (nonatomic, assign)NSInteger buyNum;

@end
