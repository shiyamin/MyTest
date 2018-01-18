//
//  BFMessageModel.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BFMessageListModel :NSObject

@property (nonatomic, copy) NSString *messageId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *pic_list;

@property (nonatomic, copy) NSString *creatTime;

@property (nonatomic, strong) NSArray *picurl;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, copy) NSString *tagetID;

@property (nonatomic, copy) NSString *tagetType;

@property (nonatomic, copy) NSString *status;



//跳转用字段
@property (nonatomic, copy) NSString *taget_id;

@property (nonatomic, copy) NSString *taget_type;

@property (nonatomic, assign) CGFloat cellHeight;


@end
