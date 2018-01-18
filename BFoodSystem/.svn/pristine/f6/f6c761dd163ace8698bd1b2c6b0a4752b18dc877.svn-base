//
//  BFFoodDetailTopCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>


#define BFFoodDetailTopCellIdentifier   @"BFFoodDetailTopCellIdentifier"
#define BFFoodDetailTopCellHeight       260

@protocol BFFoodDetailTopCellIdelegate <NSObject>

- (void)topCellDidSelectFoodClass:(NSMutableArray *)foodClassArr;

@end

@interface BFFoodDetailTopCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UITextField *foodNameTf;

@property (weak, nonatomic) IBOutlet UILabel *promptLable;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UITextField *priceTf;

@property (weak, nonatomic) IBOutlet UIView *priceBackView;

@property (nonatomic, assign) id <BFFoodDetailTopCellIdelegate> delegate;

- (void)updataCollectionViewWithFoodClassArr:(NSMutableArray *)foodClassArr;

- (void)configFoodName:(NSString *)foodName andFoodPrice:(NSString *)foodPricce;


@end
