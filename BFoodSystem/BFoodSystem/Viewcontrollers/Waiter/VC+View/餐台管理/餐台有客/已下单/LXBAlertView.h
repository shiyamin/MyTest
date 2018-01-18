//
//  LXBAlertView.h
//  LXBAlertView
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,lxbAlertType){
    lxbAlertDefult                   = 0, //defult
    lxbAlertTextView                 = 1,
    lxbAlertSelectButtonAndTextView  = 2,
    lxbAlertMessageAndTextView       = 3,
    lxbAlertTextField                = 4,
};

@class LXBAlertView;

@protocol LXBAlertViewDelegate <NSObject>

@optional
- (void)lxb_AlertView:(LXBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)lxb_AlertView:(LXBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex Text:(NSString *)text;
///  index -1 为没有选择 , 0 1 2 ...
- (void)lxb_AlertView:(LXBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex RemarkText:(NSString *)remarkText;
//text 为输入框输入的text
- (void)lxb_AlertView:(LXBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex textField:(NSString *)text;

@end


@interface LXBAlertView : UIView

- (instancetype)initWithView:(UIView *)superView;

//title的属性
@property(nonatomic,weak)UIColor * titleColor;
@property(nonatomic,weak)UIFont * titleFont;
//message属性
@property(nonatomic,weak)UIColor * messageColor;
@property(nonatomic,weak)UIFont * messageFont;
///textView的属性
@property(nonatomic,weak)UIColor * textViewBorderColor;
@property(nonatomic,assign)CGFloat textViewBorderWidth;
@property(nonatomic,weak)UIFont *textViewFont;
@property(nonatomic,weak)UIColor * textViewTextColor;
///选择按钮的属性
@property(nonatomic,weak)UIFont * selectButtonTextFont;
@property(nonatomic,weak)UIColor *selectButtonTextColor;

@property(nonatomic,weak)UIFont * buttonTextFont;
@property(nonatomic,weak)UIColor * cancalButtonBgColor;
@property(nonatomic,weak)UIColor * determineButtonBgColor;

//自定义传值
@property(nonatomic,strong)id customValue;

///只显示textView
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;
///只显示message
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate Message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;
///选择按钮和textView
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageButtonTitle:(NSArray *)buttonTitleArray cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;
///message 和 textView
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageAndTextView:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

//对象方法
///type 为lxbAlertTextView 只有textView
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

///默认type  提示语 -- message -- 按钮
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate Message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

///有选择的按钮（同时包含textView）
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageButtonTitle:(NSArray *)buttonTitleArray cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

//messageAndTextView
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageAndTextView:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle;

-(void)dismiss;
@end
