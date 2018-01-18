//
//  ZJFMessageTextFieldCell.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFTextFiledView.h"

#define BFTextFieldCellIdentifier   @"BFTextFieldCellIdentifier"


@interface ZJFMessageTextFieldCell : UITableViewCell

@property (nonatomic, strong)UITextField *textfiled;
@property (nonatomic, strong)UIImageView *imgView;

- (void)configImage:(NSString *)imageStr textfiledPlaceholder:(NSString *)textplaceholder;

@end
