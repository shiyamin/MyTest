//
//  ZJFMessageTextFieldCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFMessageTextFieldCell.h"

@implementation ZJFMessageTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         _textfiled = [[UITextField alloc] initWithFrame:CGRectZero];
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
       
        
    }
    return self;
    
}

- (void)layoutSubviews {
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, WIDTH_SCREEN-20*2, 40)];
    [self addSubview:addView];
    
    addView.layer.cornerRadius = 5;
    addView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    addView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
    addView.layer.borderWidth = 1;
    addView.clipsToBounds = YES;
    
    self.textfiled.frame = CGRectMake(40, 0, WIDTH_SCREEN-80, 40);
    self.textfiled.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.textfiled.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
    self.textfiled.borderStyle = UITextBorderStyleNone;

    [addView addSubview:self.textfiled];
    

    self.imgView.frame = CGRectMake(6, 10, 20, 20);
    self.imgView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
    [addView addSubview:self.imgView];
    
}

- (void)configImage:(NSString *)imageStr textfiledPlaceholder:(NSString *)textplaceholder {
    [self.imgView setImage:[UIImage imageNamed:imageStr]];
    self.textfiled.placeholder = textplaceholder;
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
