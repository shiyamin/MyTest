//
//  BFMessageCell.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFTopLeftLabel.h"

@interface BFMessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *showMessageView;

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) UILabel *titleLabel;


//UILabel 的文字位于左上角
@property (nonatomic, strong) BFTopLeftLabel *showMessageLabel;

- (void)configCellWtihTime:(NSString *)timeStr messageStr:(NSString *)messageStr titleStr:(NSString *)titleStr picStr:(NSArray *)picStr;
@end
