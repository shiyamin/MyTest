//
//  BFAddFoodCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>


#define BFAddFoodCellIdentifier    @"BFAddFoodCellIdentifier"
#define BFAddFoodCellHeight        80


@protocol BFAddFoodCellDelegate <NSObject>

- (void)foodNumChangedWith:(NSIndexPath *)indexPath andFoodNum:(NSInteger )num isDelect:(BOOL)isAdd;

@end

@interface BFAddFoodCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *foodIcon;

@property (weak, nonatomic) IBOutlet UILabel *foodName;

@property (weak, nonatomic) IBOutlet UILabel *foodPrice;

@property (weak, nonatomic) IBOutlet UIButton *delectBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UILabel *foodNumLabl;

@property (nonatomic, assign) id <BFAddFoodCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *index;


- (void)configFoodName:(NSString *)foodName foodPrice:(NSString *)foodPrice foodNum:(NSString *)foodNum;

- (void)configFoodIcon:(NSString *)iconUrl;



@end
