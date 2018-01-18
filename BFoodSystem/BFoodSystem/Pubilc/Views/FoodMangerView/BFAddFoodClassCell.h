//
//  BFFoodTableViewCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFAddFoodClassCellIdentifier   @"BFAddFoodClassCellIdentifier"

#define BFAddFoodClassCellHeigh       40


@protocol BFAddFoodClassCellDelegate <NSObject>

- (void)delectBtnAction:(UIButton *)btn index:(NSInteger )index;

@end

@interface BFAddFoodClassCell : UITableViewCell


@property (nonatomic, assign) id<BFAddFoodClassCellDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *foodNameLable;




@property (weak, nonatomic) IBOutlet UITextField *foodLevelTf;


@property (weak, nonatomic) IBOutlet UIButton *delectBtn;


- (void)setFoodClassName:(NSString *)namestr andLevel:(NSString *)level delectBtnTag:(NSInteger)tag;

- (void)hiddenDeleteBtn:(BOOL )isHidden;


@end
