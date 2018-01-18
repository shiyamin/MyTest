//
//  LXBDiningTableCollectionViewCell.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBDiningTableCollectionViewCell.h"
#import "Masonry.h"
@interface LXBDiningTableCollectionViewCell ()

@property(nonatomic,strong)UILabel * nameLabel;
@property (nonatomic, strong) UIImageView *isPlayImgView;

@property(nonatomic,strong)UIImageView * tagImageView;

@end

@implementation LXBDiningTableCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.contentView.backgroundColor = [UIColor colorWithRed:251/255.0 green:114/255.0 blue:156/255.0 alpha:1];
    }
    return self;
}



-(void)createUI{
    
    //餐桌名字
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    _nameLabel.textColor = [UIColor colorWithHex:BF_COLOR_B0];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    _isPlayImgView = [[UIImageView alloc] init];
    //  42, 25
    [self.contentView addSubview:_isPlayImgView];
    [_isPlayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(25);
    }];
}

- (void)setModel:(BFDeskModel *)model
{
    _model = model;
    if ([_model.status integerValue] == 2) {
        _isPlayImgView.hidden = NO;
        if ([_model.isPay integerValue] == 1) {
            _isPlayImgView.image = [UIImage imageNamed:@"ct_yifu"];
        }else {
            _isPlayImgView.image = [UIImage imageNamed:@"ct_weifu"];
        }
        self.contentView.backgroundColor = [UIColor colorWithHex:BF_COLOR_L26];
        _nameLabel.text = [NSString stringWithFormat:@"%@\n%@人",StringValue(_model.name),StringValue(_model.number)];
    }else {
        _isPlayImgView.hidden = YES;
        self.contentView.backgroundColor = [UIColor colorWithHex:BF_COLOR_L27];
        _nameLabel.text = [NSString stringWithFormat:@"%@\n空台",StringValue(_model.name)];
    }


}
@end
