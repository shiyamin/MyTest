//
//  BFBusinessAuthorTableViewCell.m
//  BFoodSystem
//
//  Created by 浙江择富 on 2018/1/17.
//  Copyright © 2018年 陈名正. All rights reserved.
//

#import "BFBusinessAuthorTableViewCell.h"

@implementation BFBusinessAuthorTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a4];
        self.nameLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];
        [self.contentView addSubview:self.nameLab];
        
        
        self.picImageView = [UIImageView new];
        [self.contentView addSubview:self.picImageView];
        self.picImageView.backgroundColor = [UIColor colorWithHex:@"aeaeae"];
        
        self.upPhotoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentView addSubview:self.upPhotoBtn];
        
        [self.upPhotoBtn setTitle:@"上传图片" forState:UIControlStateNormal];
        [self.upPhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.upPhotoBtn.backgroundColor = [UIColor redColor];
        self.upPhotoBtn.layer.cornerRadius = 8;
        
        
        self.tihsiLab1 = [UILabel new];
        [self.contentView addSubview:self.tihsiLab1];
        self.tihsiLab1.text = [NSString stringWithFormat:@"1.上传清晰的证件照"];
        self.tihsiLab1.textColor = [UIColor colorWithHex:BF_COLOR_B3];
        self.tihsiLab1.font = [UIFont systemFontOfSize:BF_FONTSIZE_L7];
        
        self.tihsiLab2 = [UILabel new];
        [self.contentView addSubview:self.tihsiLab2];
        self.tihsiLab2.text = [NSString stringWithFormat:@"2.清晰显示证件信息"];
        self.tihsiLab2.textColor = [UIColor colorWithHex:BF_COLOR_B3];
        self.tihsiLab2.font = [UIFont systemFontOfSize:BF_FONTSIZE_L7];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(25);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(160);
        make.top.mas_equalTo(self.nameLab.mas_bottom);
    }];
    
    [self.upPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.picImageView.mas_bottom);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(36);
    }];
    
    [self.tihsiLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.upPhotoBtn);
        make.bottom.equalTo(self.upPhotoBtn.mas_top).offset(-8);
        make.right.equalTo(self.upPhotoBtn);
        make.height.mas_equalTo(30);
         
         
         }] ;
    
    [self.tihsiLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tihsiLab1);
        make.bottom.equalTo(self.tihsiLab1.mas_top).offset(-10);
        make.right.equalTo(self.tihsiLab1);
        make.top.equalTo(self.contentView).offset(65);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    if (IS_IPhone6plus) {
        [self.imageTopContras setConstant:14];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
