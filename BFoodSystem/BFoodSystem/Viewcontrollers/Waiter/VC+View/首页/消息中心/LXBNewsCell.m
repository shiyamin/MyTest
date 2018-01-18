//
//  LXBNewsCell.m

//
//  Created by mac on 2017/4/10.
//  Copyright © 2017年 binbin. All rights reserved.
//

#import "LXBNewsCell.h"
#import "Masonry.h"
#import "UILabel+LXBCustomlabel.h"

#define LXBColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];

@implementation LXBNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self steup];
    }
    return  self;
}
-(void)steup
{
//    self.layer.borderWidth = 1.0;
//    self.layer.borderColor = [UIColor colorWithHex:BF_COLOR_L19].CGColor;
    self.contentView.backgroundColor  = LXBColorRGB(245, 245, 245);
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    _dateLabel.textColor = [UIColor colorWithHex:BF_COLOR_L19];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.borderWidth = 1.0;
    _bgView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_L16].CGColor;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_dateLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(60);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [_bgView addSubview:_titleLabel];
    
    _titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    _titleLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(15);
        make.top.equalTo(_bgView.mas_top).offset(10);
        make.right.equalTo(_bgView.mas_right).offset(-55);
    }];
    
  
    _messageLabel = [[UILabel alloc]init];
    [_bgView addSubview:_messageLabel];

    _messageLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.numberOfLines = 0;

    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(15);
        make.top.equalTo(self.titleLabel.mas_top).offset(25);
        make.right.equalTo(_bgView.mas_right).offset(-15);
    }];
    
    _statusLabel = [[UILabel alloc]init];
    [_bgView addSubview:_statusLabel];
    
    _statusLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    _statusLabel.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    _statusLabel.textAlignment = NSTextAlignmentRight;
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left).offset(10);
        make.top.equalTo(_bgView.mas_top).offset(10);
        make.right.equalTo(_bgView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
}
-(void)setModle:(BFMessageListModel *)modle{
    _modle = modle;
    _titleLabel.text = modle.title;
    _messageLabel.text = modle.content;
    NSString *status = [NSString stringWithFormat:@"%@",modle.status];
    if ([status isEqualToString:@"2"]) {
        _statusLabel.text = @"已处理";
    } else if ([status isEqualToString:@"1"]){
        _statusLabel.text = @"";
    }
    
//    [UILabel changeLineSpaceForLabel:_messageLabel WithSpace:5.0];
    _dateLabel.text = modle.creatTime;
    
    CGFloat bgHeight = [self getHeight:modle.content] + 50;
    _cellHeight = bgHeight;
    [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_cellHeight);
    }];
    
}

-(float)getHeight:(NSString *)content{
    float width=[UIScreen mainScreen].bounds.size.width-60;
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:BF_FONTSIZE_a2]} context:nil].size;
    return size.height;
}

-(NSString *)stringWithDate:(NSTimeInterval)timeDate{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeDate];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}
@end
