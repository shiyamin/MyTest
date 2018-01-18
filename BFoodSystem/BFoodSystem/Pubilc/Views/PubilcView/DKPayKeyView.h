//
//  DKPayKeyView.h
//  bombDemo
//
//  Created by 名正 on 15/10/13.
//  Copyright © 2015年 名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKPayKeyViewDelegate <NSObject>

- (void)submitBtnActionWithText:(NSString *)text;

- (void)backgroundViewTouched;

@end

@interface DKPayKeyView : UIView

@property (nonatomic, assign) id <DKPayKeyViewDelegate> delegate;

//初始化方法，num 为想创建多少个框。
- (instancetype)initWithNum:(NSInteger )integer;


- (void)configTitleLable:(NSString *)title;


- (void)setViewToDefault;

- (void)payViewShowKeyboard;


- (void)payViewHiddenKeyboard;

@end
