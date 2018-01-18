//
//  BFFoodTableCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFFoodTableCellIdentifier   @"BFFoodTableCellIdentifier"
#define BFFoodTableCellIHeight      80

@protocol BFFoodTableCellDelegate <NSObject>

@optional

- (void)saleStatusBtnAction:(UIButton *)statusBtn andType:(NSString *)typeStr indesPath:(NSIndexPath *)index;

- (void)middleBtnOnSaleAction:(UIButton *)sender indesPath:(NSIndexPath *)index;

@end

@interface BFFoodTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconView;



@property (weak, nonatomic) IBOutlet UILabel *FoodNameLable;



@property (weak, nonatomic) IBOutlet UILabel *priceLable;



@property (weak, nonatomic) IBOutlet UIButton *onSaleBtn;


@property (weak, nonatomic) IBOutlet UIButton *offSaleBtn;

@property (weak, nonatomic) IBOutlet UIButton *middleSaleBtn;

@property (nonatomic, assign) id<BFFoodTableCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;


- (void)configFoodImage:(NSString *)imageName foodName:(NSString *)nameStr foodPrice:(NSString *)price;


/**
 隐藏上架下架按钮
 */
- (void)hiddenSalesButton;

//隐藏中间的上架按钮
- (void)hiddenMiddleButton;

- (void)setSaleStatusWithOnSale:(BOOL)isOnSale;




@end
