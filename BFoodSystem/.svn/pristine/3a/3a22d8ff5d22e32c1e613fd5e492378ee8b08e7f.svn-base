//
//  BFHomeTopView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFQueryDailyModel.h"

@protocol BFHomeTopViewDelegate <NSObject>

- (void)refreshHeadViewData;

@end

@interface BFHomeTopView : UIView



@property (weak, nonatomic) IBOutlet UILabel *leftLable;

@property (weak, nonatomic) IBOutlet UILabel *rightLable;


@property (nonatomic, assign) id <BFHomeTopViewDelegate> delegate;


- (void)configTopInfoWith:(BFQueryDailyModel *)model;



@end
