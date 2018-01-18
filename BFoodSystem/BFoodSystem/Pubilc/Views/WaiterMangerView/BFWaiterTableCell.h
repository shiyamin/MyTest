//
//  BFWaiterTableCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFWaiterTableCellIdentifier   @"BFWaiterTableCellIdentifier"
#define BFWaiterTableCellHeight       100

@interface BFWaiterTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *responsAreaLable;



- (void)configPersonName:(NSString *)nameStr personOpsition:(NSString *)opsition headIcon:(NSString *)iconStr loginType:(NSInteger)type;



@end
