//
//  BFDataSearchView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDataSearchView.h"

@interface BFDataSearchView (){
    UIButton *_backGroundView;
    UIDatePicker *_dataPicker;
}

@property (nonatomic, copy) NSString *dataStr;

@property (nonatomic, assign) timeType selectTimeType;

@end

@implementation BFDataSearchView

- (NSString *)dataStr{
    if (!_dataStr) {
        _dataStr = [NSString string];
    }
    return _dataStr;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    
    NSArray *backViewArr = @[self.beginBackView,self.endBackView];
    for (UIView *view in backViewArr) {
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.clipsToBounds = YES;
        view.layer.borderWidth = 1;
    }
    
    self.beginTime.font=[UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.beginTime.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.beginTime.text = @"选择日期";
    
    self.endTime.font=[UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.endTime.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.endTime.text = @"选择日期";

    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.clipsToBounds = YES;
    [self.submitBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    [self.submitBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    
    
    self.beginTimeTitle.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    self.endTimeTitle.textColor =[UIColor colorWithHex:BF_COLOR_B3];
    
    self.tipsLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.tipsLable.textColor  = [UIColor colorWithHex:BF_COLOR_B10];
    self.tipsLable.text = @"提示：只提供以月为单位的查询服务";
    
}

- (void)hiddenTipsLableAndImage{
    self.tipsLable.hidden = YES;
    self.tipsImageView.hidden = YES;
}


- (IBAction)submitAction:(UIButton *)sender {
    
    if ([self.beginTime.text isEqualToString:@"选择日期"] || [self.beginTime.text isEqualToString:@"选择日期"]) {
        [BFUtils showAlertController:0 title:@"" message:@"请选择日期"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(searchBtnActionWithBeginTime:endTime:)]) {
        [self.delegate searchBtnActionWithBeginTime:self.beginTime.text endTime:self.endTime.text];
    }
    
}

- (IBAction)beginBtnAction:(UIButton *)sender {
    self.selectTimeType = beginTime;
    [self addTimePickerView];
}


- (IBAction)endBtnAction:(UIButton *)sender {
    self.selectTimeType = endTime;
    [self addTimePickerView];

}



- (void)addTimePickerView{
    _backGroundView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView setFrame:[UIScreen mainScreen].bounds];
    _backGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [_backGroundView addTarget:self action:@selector(removeBackView) forControlEvents:UIControlEventTouchUpInside];
    [KEY_WINDOW addSubview:_backGroundView];
    
    _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250)/2, (SCREEN_HEIGHT-180)/2, 250, 180)];
    [_dataPicker addTarget:self action:@selector(dateChange:) forControlEvents: UIControlEventValueChanged];
    _dataPicker.datePickerMode = UIDatePickerModeDate;
    NSDate *todayData = [NSDate date];
    _dataPicker.maximumDate = todayData;
    _dataPicker.backgroundColor= [UIColor whiteColor];
    _dataPicker.layer.borderColor = [UIColor grayColor].CGColor;
    _dataPicker.layer.borderWidth = 1;
    [_backGroundView addSubview:_dataPicker];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
     self.dataStr = [formatter stringFromDate:_dataPicker.date];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(_dataPicker.frame.origin.x, SCREEN_HEIGHT/2+ 90, 250, 40)];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:sureBtn];
    
}

- (void)sureAction:(UIButton *)sender{
    if (self.selectTimeType == beginTime) {
        self.beginTime.text = self.dataStr;
    }else if (self.selectTimeType == endTime){
        self.endTime.text = self.dataStr;
    }
    [self removeview];
}


- (void)removeBackView{
    [self removeview];
}


- (void)removeview{
    [_backGroundView removeFromSuperview];
    [_dataPicker removeFromSuperview];
}


- (void)dateChange:(UIDatePicker *)senser{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dataStr = [formatter stringFromDate:_dataPicker.date];
    BFLog(@"====%@", self.dataStr);
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
