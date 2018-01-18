//
//  ZJFTextViewCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFTextViewCell.h"

@interface ZJFTextViewCell ()<UITextViewDelegate>

@end

@implementation ZJFTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _bottomLable = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
    
}


- (void)layoutSubviews{
    
    self.textView.frame = CGRectMake(20, 10, WIDTH_SCREEN-40, 100);
    self.textView.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.clipsToBounds = YES;
    self.textView.text = @"请输入消息详情";
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
    self.bottomLable.frame = CGRectMake(25, 110, 200, 30);
    self.bottomLable.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    self.bottomLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.bottomLable.text = @"添加图片";
    [self addSubview:self.bottomLable];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@"请输入消息详情"] && self.textView.isFirstResponder) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    return YES;
}

- (void)textViewPlacehodel{
    self.textView.text = @"请输入消息详情";
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
}

- (void)setTextViewText:(NSString *)textStr{
    self.textView.text = textStr;
    self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B5];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@""]) {
        self.textView.text = @"请输入消息详情";
        self.textView.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
