//
//  LXBHeaderView.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBHeaderView.h"
#import "Masonry.h"
@interface LXBHeaderView ()

@property(nonatomic,strong)UILabel * headerLabel;

@end
@implementation LXBHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_L16];
    
    _headerLabel = [[UILabel alloc]init];
    _headerLabel.textColor = [UIColor colorWithHex:BF_COLOR_L22];
    _headerLabel.textAlignment = NSTextAlignmentLeft;
    _headerLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self addSubview:_headerLabel];
    
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(15);
        make.centerY.mas_equalTo(self);
    }];
    
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    
    _headerLabel.text = titleString;
}

@end
