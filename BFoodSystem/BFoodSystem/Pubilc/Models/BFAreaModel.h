//
//  BFAreaModel.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFAreaModel : NSObject

@property (nonatomic, strong) NSArray *desk_list;
@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *waiter_list;

@property (nonatomic, assign) BOOL  isSelect;






@end
