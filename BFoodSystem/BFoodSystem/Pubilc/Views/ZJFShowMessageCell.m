//
//  ZJFShowMessageCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFShowMessageCell.h"

@implementation ZJFShowMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _showMessageLabel = [[BFTopLeftLabel alloc] initWithFrame:CGRectZero];
        _showMessageView = [[UIView alloc] initWithFrame:CGRectZero];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        
    }
    return self;
    
}

- (void)layoutSubviews {
    
        _timeLabel.frame = CGRectMake(0, 20, WIDTH_SCREEN, 30);
        _timeLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
        [self addSubview:self.timeLabel];
        
        _showMessageView.frame = CGRectMake(20, 55, WIDTH_SCREEN-40, 95);
        _showMessageView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
        _showMessageView.layer.borderWidth = 1;
        _showMessageView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
        [self addSubview:self.showMessageView];
        
        _titleLabel.frame = CGRectMake(10, 5, WIDTH_SCREEN- 40 - 45, 20);
        _titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        _titleLabel.textColor = [UIColor colorWithHex:BF_COLOR_B4];
        [self.showMessageView addSubview:self.titleLabel];
        
        _showMessageLabel.frame = CGRectMake(10, 25, self.showMessageView.frame.size.width-85, self.showMessageView.frame.size.height-25);
        _showMessageLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
        _showMessageLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        _showMessageLabel.adjustsFontSizeToFitWidth = YES;
        _showMessageLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        
        [self.showMessageView addSubview:self.showMessageLabel];
        
        
}

- (void)configCellWtihTime:(NSString *)timeStr messageStr:(NSString *)messageStr titleStr:(NSString *)titleStr{
    self.timeLabel.text = timeStr;
    self.showMessageLabel.text = messageStr;
    self.titleLabel.text = titleStr;
    
    self.showMessageLabel.numberOfLines = 0;
}

- (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor{
    //分段样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    //富文本样式
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : font,
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : textColor
                                   };
    return attributeDic;
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
