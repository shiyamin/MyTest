//
//  BFFoodClassPopController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"

@protocol BFFoodClassPopControllerDelegate <NSObject>


/**
 点击cell的回调

 @param index 点击位置
 @param type 是否是分类管理
 */
- (void)didSelectRowAtIndex:(NSIndexPath *)index andSelectType:(NSString *)type;

@end

@interface BFFoodClassPopController : BFBaseViewController


@property(nonatomic, assign) id <BFFoodClassPopControllerDelegate> delegate;

@property (nonatomic, copy) NSString *vcIdentifier;


- (void)updateAreaWithDataArr:(NSArray *)dataArr;



@end
