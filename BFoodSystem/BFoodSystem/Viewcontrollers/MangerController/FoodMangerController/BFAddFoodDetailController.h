//
//  BFAddFoodDetailController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFFoodModel.h"

typedef enum : NSUInteger {
    foodDetailNew,
    foodDetailChange,
} FoodDetailType;



@protocol BFAddFoodDetailControllerDelegate <NSObject>

- (void)updataTabbleViewData;

@end

@interface BFAddFoodDetailController : BFBaseViewController

@property (nonatomic, assign) FoodDetailType foodVcType;

@property (nonatomic, strong) BFFoodModel *foodModel;

@property (nonatomic, assign) id<BFAddFoodDetailControllerDelegate> delegate;

@end
