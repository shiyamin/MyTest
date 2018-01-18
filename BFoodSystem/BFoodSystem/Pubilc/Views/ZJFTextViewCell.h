//
//  ZJFTextViewCell.h
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZJFTextViewCellIdentifier   @"ZJFTextViewCellIdentifier"
#define ZJFTextViewCellHeight       140

@interface ZJFTextViewCell : UITableViewCell
@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UILabel *bottomLable;


- (void)textViewPlacehodel;

- (void)setTextViewText:(NSString *)textStr;
@end
