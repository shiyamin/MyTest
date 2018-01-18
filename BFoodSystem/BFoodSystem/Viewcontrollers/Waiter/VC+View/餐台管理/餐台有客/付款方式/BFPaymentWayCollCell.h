//
//  BFPaymentWayCollCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFPaymentWayCollCellIdentifier  @"BFPaymentWayCollCellIdentifier"


@interface BFPaymentWayCollCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLable;


- (void)configIconWithIconName:(NSString *)iconStr titleName:(NSString *)titleStr;



@end
