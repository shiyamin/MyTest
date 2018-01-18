//
//  BFAreaTabbleCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFAreaTabbleCellIdentifier    @"BFAreaTabbleCellIdentifier"
#define BFAreaTabbleCellHeight        40

@protocol BFAreaTabbleCellDelegate <NSObject>

- (void)tabbleViewCellDelectBtnAction:(UIButton *)button;

@end

@interface BFAreaTabbleCell : UITableViewCell

@property (nonatomic, assign) id<BFAreaTabbleCellDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UILabel *leftLable;

@property (weak, nonatomic) IBOutlet UITextField *areaTextField;

@property (weak, nonatomic) IBOutlet UIButton *delectBtn;







@end
