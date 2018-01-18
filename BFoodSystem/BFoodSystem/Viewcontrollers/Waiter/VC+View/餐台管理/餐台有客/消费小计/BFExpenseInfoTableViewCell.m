//
//  BFExpenseInfoTableViewCell.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/26.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFExpenseInfoTableViewCell.h"
#define KLabelMargin (IS_IPhone5? 20:40)
@interface BFExpenseInfoTableViewCell ()
@property (nonatomic, strong) UILabel *nameLab;//菜名
@property (nonatomic, strong) UILabel *priceLab;//价格
@property (nonatomic, strong) UILabel *numLab;//数量
@property (nonatomic, strong) UILabel *totalPriceLab;//总价格
@end

@implementation BFExpenseInfoTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"XBExpensedMoneyCell";
    BFExpenseInfoTableViewCell *cell = [tableview  dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[BFExpenseInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creationViewFunciton];
    }
    return self;
}
- (void)creationViewFunciton {
    UIView *sub = self.contentView;
//    sub.layer.masksToBounds = YES;
//    sub.layer.cornerRadius = 5.0f;
//    sub.layer.borderWidth = 1.0f;
    sub.layer.borderColor = [UIColor colorWithHex:BF_COLOR_L19].CGColor;
    sub.backgroundColor = [UIColor whiteColor];
    UIFont *textFont = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = [UIColor colorWithHex:BF_COLOR_L19];
    nameLabel.font = textFont;
    [sub addSubview:nameLabel];
    _nameLab = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub).offset(10);
        make.centerY.equalTo(sub);
        make.height.mas_equalTo(16);
    }];
    UILabel *totalPriceLabel = [UILabel new];
    totalPriceLabel.textColor = [UIColor colorWithHex:BF_COLOR_B11];
    totalPriceLabel.font = textFont;
    [sub addSubview:totalPriceLabel];
    _totalPriceLab = totalPriceLabel;
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sub).offset(-10);
        make.centerY.equalTo(sub);
        make.height.mas_equalTo(16);
    }];

    UILabel *numLabel = [UILabel new];
    numLabel.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    numLabel.font = textFont;
    [sub addSubview:numLabel];
    _numLab = numLabel;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_totalPriceLab.mas_left).with.offset(-KLabelMargin);
        make.centerY.equalTo(sub);
        make.height.mas_equalTo(16);
    }];
    UILabel *priceLabel = [UILabel new];
    priceLabel.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    priceLabel.font = textFont;
    [sub addSubview:priceLabel];
    _priceLab = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_numLab.mas_left).offset(-KLabelMargin);
        make.centerY.equalTo(sub);
        make.height.mas_equalTo(16);
    }];
    
    
    
    
}

- (void)setCookingModel:(LXBCookingdetailModel *)cookingModel
{
    NSString *price = cookingModel.price;
    NSString *number = [NSString stringWithFormat:@"%@",cookingModel.quantity];
    _nameLab.text = cookingModel.name;
    _priceLab.text = [NSString stringWithFormat:@"￥%@",cookingModel.price];
    _numLab.text = [NSString stringWithFormat:@"x %@",number];
    CGFloat total = [number integerValue] * [price floatValue];
    _totalPriceLab.text = [NSString stringWithFormat:@"%.2f元",total];
    
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


