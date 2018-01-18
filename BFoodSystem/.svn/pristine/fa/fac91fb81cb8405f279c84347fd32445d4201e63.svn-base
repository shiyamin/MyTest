//
//  LXBAlertView.m
//  LXBAlertView
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBAlertView.h"


#define TitleHeight 50  //提醒语的高度
#define messageHeight 150/2 //message高度
#define buttonHeight 36 //按钮的高度
#define contentHeight 250 //整个contentView的高度
#define contentWidth SCREEN_WIDTH * 0.8 //宽度
#define spacing 10
#define lineHeight 0.5
#define textViewHeight 60
@interface LXBAlertContentView : UIView
{
	UILabel * _titleLabel;
    UITextView * _textView;
    UIButton * _cancleButton;
    UIButton * _determineButton;
    CGFloat _contentHeight;
    NSInteger _count;
    UILabel * _messageLabel;
    lxbAlertType _type;
    UITextField * _textField;
}
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

@property(nonatomic,strong)IQKeyboardManager * keyboardmanager;

@property(nonatomic,weak)id<LXBAlertViewDelegate> delegate;

@property(nonatomic,copy)NSArray * array;

-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageTitle:(NSString *)message SelectButtonTitle:(NSArray *)buttonTitleArray textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle Type:(lxbAlertType)type;

@end

@implementation LXBAlertContentView

-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageTitle:(NSString *)message SelectButtonTitle:(NSArray *)buttonTitleArray textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle Type:(lxbAlertType)type{
	
    _keyboardmanager = [IQKeyboardManager sharedManager];
    
    _type = type;
	
	_array = buttonTitleArray;
	
    _count = buttonTitleArray.count;
    
    _delegate = delegate;
    
    if (![title isEqualToString:@""]) {
        _titleLabel = [UILabel new];
        _titleLabel.font = self.titleFont;
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor colorWithHex:BF_COLOR_B10];
        _titleLabel.numberOfLines = 0;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _contentHeight += TitleHeight;
    }
    
    if (type == lxbAlertDefult) {
        _messageLabel = [UILabel new];
        _messageLabel.font = self.messageFont;
        _messageLabel.text = message;
        _messageLabel.textColor = self.messageColor;

        _messageLabel.numberOfLines = 0;
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
        
        _contentHeight += messageHeight;
    }
    
    if (type == lxbAlertSelectButtonAndTextView) {
        NSInteger i = 0;
        for (NSString * buttonTitle in buttonTitleArray) {
            [self creatButtonWithTitle:buttonTitle Num:i];
            i++;
        }
        _contentHeight += (buttonTitleArray.count/2 + 1) * (buttonHeight+spacing);
        
        //    获取到最后一个btn
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor colorWithHex:BF_COLOR_L25];
        _textView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.font = self.textViewFont;
        _textView.layer.cornerRadius = 8.0f;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;;
        _textView.layer.borderWidth = self.textViewBorderWidth;
        _textView.scrollEnabled = NO;
        
        [self addSubview:_textView];
        
        _contentHeight += textViewHeight;
        
    }else if (type == lxbAlertTextView){
        //    获取到最后一个btn
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
        _textView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.font = self.textViewFont;
        _textView.layer.cornerRadius = 8.0f;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = self.textViewBorderColor.CGColor;
        _textView.layer.borderWidth = self.textViewBorderWidth;
        _textView.scrollEnabled = NO;
        [self addSubview:_textView];
        _contentHeight += textViewHeight;
    }else if (type == lxbAlertMessageAndTextView){
        
        _messageLabel = [UILabel new];
        _messageLabel.font = self.messageFont;
        _messageLabel.text = message;
        _messageLabel.textColor = self.messageColor;
        _messageLabel.numberOfLines = 0;
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
        
        CGSize  size = [_messageLabel.text boundingRectWithSize:CGSizeMake(contentWidth , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_messageLabel.font} context:nil].size;
        
        _contentHeight += size.height;
        
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
        _textView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.font = self.textViewFont;
        _textView.layer.cornerRadius = 8.0f;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = self.textViewBorderColor.CGColor;
        _textView.layer.borderWidth = self.textViewBorderWidth;
        _textView.scrollEnabled = NO;
        [self addSubview:_textView];
        _contentHeight += textViewHeight;
    }else if(type == lxbAlertTextField){
        _textField = [[UITextField alloc]init];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.placeholder = textFieldPlaceholder;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textField];
        _contentHeight += messageHeight;
    }
    
    
  
    if (![cancelButtonTitle isEqualToString:@""]) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_cancleButton];
        _cancleButton.backgroundColor = self.cancalButtonBgColor;
        [_cancleButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = self.buttonTextFont;
        
        _cancleButton.titleLabel.numberOfLines = 0;
        _cancleButton.tag = 110;
        [_cancleButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (![determineButtonTitle isEqualToString:@""] ) {
        _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _determineButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_determineButton];
        _determineButton.backgroundColor = self.determineButtonBgColor;
//        _determineButton.backgroundColor = [UIColor redColor];
        [_determineButton setTitle:determineButtonTitle forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _determineButton.titleLabel.font = self.buttonTextFont;
        _determineButton.titleLabel.numberOfLines = 0;
        _determineButton.tag = 110 + 1;
        [_determineButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

//    _contentHeight += TitleHeight;
    _contentHeight += 4;
    
    
    
    [self setNeedsUpdateConstraints];
}

#pragma  mark - 重新布局子视图
- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
//    NSLog(@"%@",NSStringFromCGRect(_determineButton.frame));
//    NSLog(@"%@",NSStringFromCGRect(_textView.frame));
    if (_titleLabel) {
        CALayer *layer = [CALayer layer];
        CGFloat height = _titleLabel.bounds.size.height - 1.0;
        CGFloat width = self.bounds.size.width;
        layer.frame = CGRectMake(0.01f, height, width, 1.0f);
        layer.backgroundColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
        [self.layer addSublayer:layer];
    }
    if (_textView) {
        CALayer *layer = [CALayer layer];
        CGFloat height = _textView.frame.origin.y  + _textView.frame.size.height + 9;
        CGFloat width = self.bounds.size.width;
        layer.frame = CGRectMake(0.01f, height, width, 1.0f);
        layer.backgroundColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
        [self.layer addSublayer:layer];
    }
    if (_determineButton) {

        CALayer *layer1 = [CALayer layer];
        CGFloat height1 = _determineButton.frame.origin.y;
        layer1.frame = CGRectMake(_determineButton.frame.origin.x, height1, 1.0f, _determineButton.frame.size.height);
        layer1.backgroundColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
        [self.layer addSublayer:layer1];
    }
}



-(void)creatButtonWithTitle:(NSString *)title Num:(NSInteger)num{
    UIView * maskView = [self creatButtonViewWithTitle:title Num:num];
    maskView.tag = 10086+num;
    [self addSubview:maskView];
}

-(UIView *)creatButtonViewWithTitle:(NSString *)title Num:(NSInteger)num{
    UIView * maskView = [[UIView alloc]init];
    maskView.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];

    if (num == 0) {
        btn.selected = YES;
    }
    [btn setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"dm_xuanzhong"] forState:UIControlStateSelected];
   
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:self.textViewTextColor forState:UIControlStateNormal];
    if (IS_IPhone5) {
        btn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a0];
    }else {
        
        btn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    }
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.tag = 12306 + num;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:btn];

    return maskView;
}

-(void)buttonAction:(UIButton *)btn{
   //选择的按钮 12306 + i
    for (NSInteger i=0; i<_count; i++) {
        UIButton * btn = [self viewWithTag:12306+i];
        btn.selected = NO;
    }
    
    btn.selected = !btn.selected;
	if (btn.tag == 12306 + 3) {
		_textView.editable = YES;
		[_textView becomeFirstResponder];
	}else{
		_textView.editable = NO;
		[_textView resignFirstResponder];
	}
}

-(void)btnClick:(UIButton *)btn{
	//取消按钮和确定按钮
    if (_type == lxbAlertDefult ) {
        if([_delegate respondsToSelector:@selector(lxb_AlertView:clickedButtonAtIndex:)]){
            [_delegate lxb_AlertView:(LXBAlertView *)self.superview clickedButtonAtIndex:btn.tag - 110];
        }
    }else if (_type == lxbAlertMessageAndTextView || _type == lxbAlertTextView ){
        if ([_delegate respondsToSelector:@selector(lxb_AlertView:clickedButtonAtIndex:Text:)]) {
            [_delegate lxb_AlertView:(LXBAlertView *)self.superview clickedButtonAtIndex:btn.tag - 110 Text:_textView.text];
        }
    }else if (_type == lxbAlertSelectButtonAndTextView){
        if ([_delegate respondsToSelector:@selector(lxb_AlertView:clickedButtonAtIndex:RemarkText:)]) {
			
			NSString *  remark = @"";
			NSInteger selectIndex = -1;
            for (NSInteger i=0; i<_count; i++) {
                UIButton * btn = [self viewWithTag:12306+i];
                if (btn.selected) {
                    selectIndex = btn.tag - 12306;
					if (btn.tag != 12306 + _count - 1) {
						remark = _array[selectIndex];
					}else{
						remark = _textView.text;
					}
                }
            }
            
            
            [_delegate lxb_AlertView:(LXBAlertView *)self.superview clickedButtonAtIndex:btn.tag - 110 RemarkText:remark];
        }
    }else if (_type == lxbAlertTextField){
        if ([_delegate respondsToSelector:@selector(lxb_AlertView:clickedButtonAtIndex:textField:)] ) {
            [_delegate lxb_AlertView:(LXBAlertView *)self.superview clickedButtonAtIndex:btn.tag -110 textField:_textField.text];
        }
    }
    
    LXBAlertView * alertView = (LXBAlertView *)self.superview;
    [alertView dismiss];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.3);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetShouldAntialias(context, NO);
    CGFloat pointX = 0;
    CGFloat pointY = TitleHeight;
    CGContextMoveToPoint(context, pointX, pointY);
    
    pointX = contentWidth;
    pointY = TitleHeight;
    CGContextAddLineToPoint(context, pointX, pointY);
    
    
    if (_cancleButton || _determineButton) {
        pointX = 0;
        pointY = _contentHeight - TitleHeight;
        CGContextMoveToPoint(context, pointX, pointY);
        
        pointX = contentWidth;
        pointY = _contentHeight - TitleHeight;
        CGContextAddLineToPoint(context, pointX, pointY);
    }
    
    
    
    if (_cancleButton && _determineButton) {
        pointX = contentWidth/2;
        pointY = _contentHeight - (TitleHeight - buttonHeight)/2;
        CGContextMoveToPoint(context, pointX, pointY);
        
        pointX = contentWidth/2;
        pointY = _contentHeight - (TitleHeight - buttonHeight)/2 - buttonHeight;
        CGContextAddLineToPoint(context, pointX, pointY);
    }
    
    
    //绘制
    CGContextStrokePath(context);
    
}

-(void)updateConstraints{
    
    [self removeConstraints:self.constraints];
    
    //title
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:TitleHeight]];
    
    if (_type == lxbAlertSelectButtonAndTextView ) {
        UIView * lastView = [self viewWithTag:10086+_count-1];
        //textView
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:textViewHeight]];
        
        //maskView (btn and label)
        CGFloat height =  buttonHeight;
        CGFloat width = contentWidth/2;
        
        for (NSInteger i = 0; i < _count; i++) {
            UIView * maskView = [self viewWithTag:10086 + i];
            UIButton * btn = [maskView viewWithTag:12306 + i];
//            UILabel * label = [maskView viewWithTag:10010 + i];
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.5+i%2 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:height*(i/2)]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:buttonHeight]];
            
            [maskView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:maskView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
            [maskView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:maskView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
            [maskView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:maskView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [maskView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:btn.currentImage.size.height]];
        }

    }else if (_type == lxbAlertTextView){
        //textView
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:textViewHeight]];
    }else if(_type == lxbAlertDefult){
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:messageHeight]];
    }else if (_type == lxbAlertMessageAndTextView){
        CGSize  size = [_messageLabel.text boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_messageLabel.font} context:nil].size;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_messageLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:textViewHeight]];
    }else if(_type == lxbAlertTextField){
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:messageHeight]];
    }
    
    if (_cancleButton) {
        
        UIView * itme2 = (_type==lxbAlertDefult)?_messageLabel:(_type == lxbAlertTextField)?_textField:_textView;
        //取消的按钮
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancleButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:_determineButton?0.5:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancleButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:itme2 attribute:NSLayoutAttributeBottom multiplier:1 constant:spacing+(TitleHeight-buttonHeight)/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancleButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_determineButton?contentWidth/2:contentWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancleButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:buttonHeight]];
    }
  
    if (_determineButton) {
        //确定的按钮
        UIView * itme2 = (_type==lxbAlertDefult)?_messageLabel:(_type == lxbAlertTextField)?_textField:_textView;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_determineButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:_cancleButton?1.5:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_determineButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:itme2 attribute:NSLayoutAttributeBottom multiplier:1 constant:spacing+(TitleHeight-buttonHeight)/2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_determineButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_cancleButton?contentWidth/2:contentWidth]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_determineButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:buttonHeight]];
    }
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentWidth]];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_contentHeight]];
    
    [super updateConstraints];
    
    [_titleLabel layoutIfNeeded];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
	
}
@end

//------------------------------------------------------------------------------------------------------------------------------------
@implementation LXBAlertView
{
    __weak UIView * _superView;
    LXBAlertContentView * _contentView;
}

- (instancetype)initWithView:(UIView *)superView {
    if (self = [super init]) {
        _superView = superView;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self configurationDefult];
    }
    return self;
}

-(void)configurationDefult{
    _titleColor = [UIColor blackColor];
    _titleFont = [UIFont boldSystemFontOfSize:14];
    _messageColor = [UIColor blackColor];
    _messageFont = [UIFont systemFontOfSize:14];
    _textViewBorderColor = [UIColor colorWithHex:BF_COLOR_B10];
    _textViewBorderWidth = 1.0;
    _textViewFont = [UIFont systemFontOfSize:14];
    _textViewTextColor = [UIColor blackColor];
    _selectButtonTextFont = [UIFont systemFontOfSize:14];
    _selectButtonTextColor = [UIColor blackColor];
    _buttonTextFont = [UIFont systemFontOfSize:16];
    _cancalButtonBgColor = [UIColor clearColor];
    _determineButtonBgColor = [UIColor clearColor];
    
}

+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    LXBAlertView * alertView = [[LXBAlertView alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [alertView showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertTextView];
}

+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate Message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
	LXBAlertView * alertView = [[LXBAlertView alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [alertView showWithTitle:title Delegate:delegate MessageTitle:message SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertDefult];
}
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageButtonTitle:(NSArray *)buttonTitleArray cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    LXBAlertView * alertView = [[LXBAlertView alloc]initWithView:[UIApplication sharedApplication].keyWindow];
	[alertView showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:buttonTitleArray textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertSelectButtonAndTextView];
}

+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageAndTextView:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    LXBAlertView * alertView = [[LXBAlertView alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [alertView showWithTitle:title Delegate:delegate MessageTitle:message SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertMessageAndTextView];
}
+(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
	LXBAlertView * alertView = [[LXBAlertView alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [alertView showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:@[] textField:textFieldPlaceholder cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertTextField];
}


-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    [self showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertTextView];
}
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate Message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    [self showWithTitle:title Delegate:delegate MessageTitle:message SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertDefult];
}

#pragma mark - 弹出消息
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageButtonTitle:(NSArray *)buttonTitleArray cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    [self showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:buttonTitleArray textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertSelectButtonAndTextView];
}
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageAndTextView:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
    
    [self showWithTitle:title Delegate:delegate MessageTitle:message SelectButtonTitle:@[] textField:@"" cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertMessageAndTextView];
}

-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle{
	[self showWithTitle:title Delegate:delegate MessageTitle:@"" SelectButtonTitle:@[] textField:textFieldPlaceholder cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:lxbAlertTextField];
}

//设置信息;
-(void)showWithTitle:(NSString *)title Delegate:(id<LXBAlertViewDelegate>)delegate MessageTitle:(NSString *)message SelectButtonTitle:(NSArray *)buttonTitleArray textField:(NSString *)textFieldPlaceholder cancelButtonTitle:(NSString *)cancelButtonTitle determineButtonTitle:(NSString *)determineButtonTitle Type:(lxbAlertType)type{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_superView addSubview: self];
        
        [_superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_superView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [_superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [_superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_superView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [_superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_superView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        _contentView = [[LXBAlertContentView alloc]init];
        [self addSubview:_contentView];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
        
        _contentView.titleColor = _titleColor;
        _contentView.titleFont = _titleFont;
        _contentView.messageColor = _messageColor;
        _contentView.messageFont = _messageFont;
        _contentView.textViewBorderColor = _textViewBorderColor;
        _contentView.textViewBorderWidth = _textViewBorderWidth;
        _contentView.textViewFont = _textViewFont;
        _contentView.textViewTextColor = _textViewTextColor;
        _contentView.selectButtonTextFont =_selectButtonTextFont ;
        _contentView.selectButtonTextColor = _selectButtonTextColor;
        _contentView.buttonTextFont = _buttonTextFont;
        _contentView.cancalButtonBgColor = _cancalButtonBgColor ;
        _contentView.determineButtonBgColor = _determineButtonBgColor;
        
        _contentView.titleColor = _titleColor;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [_contentView showWithTitle:title Delegate:delegate MessageTitle:message SelectButtonTitle:buttonTitleArray textField:textFieldPlaceholder cancelButtonTitle:cancelButtonTitle determineButtonTitle:determineButtonTitle Type:type];

    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
- (void)dismiss {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}


@end
