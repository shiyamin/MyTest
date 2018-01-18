//
//  BFWithdrawCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFWithdrawCellIdentifier   @"BFWithdrawCellIdentifier"
#define BFWithdrawCellHeight       100


@protocol BFWithdrawCellDelegate <NSObject>

- (void)didSelectWithdrawBtn:(NSIndexPath *)indexPath;

@end


@interface BFWithdrawCell : UITableViewCell




@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *numLable;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLable;

@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;

@property (strong, nonatomic) NSIndexPath *indexPat;

@property (strong, nonatomic) id <BFWithdrawCellDelegate> delegate;

- (void)configCellWithPersonName:(NSString *)nameStr bankNum:(NSString *)bankNumStr bankName:(NSString *)bankNameStr;


@end
