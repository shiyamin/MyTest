//
//  ZJFShowMessageCell.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFTopLeftLabel.h"

@interface ZJFShowMessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *showMessageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) BFTopLeftLabel *showMessageLabel;


- (void)configCellWtihTime:(NSString *)timeStr messageStr:(NSString *)messageStr titleStr:(NSString *)titleStr;
@end
