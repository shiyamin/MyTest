//
//  BFFoodTableCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodTableCell.h"

@implementation BFFoodTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}



- (void)setStatusForSubViews{
    self.FoodNameLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.FoodNameLable.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    
    self.priceLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.priceLable.textColor = [UIColor colorWithHex:BF_COLOR_B11];
    
    NSArray *btnArr = @[self.onSaleBtn,self.offSaleBtn];
    for (UIButton *button in btnArr) {
        button.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        [button setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 0)];
    }
    [self.onSaleBtn setTitle:@"上架" forState:UIControlStateNormal];
    [self.onSaleBtn setTitleColor:[UIColor colorWithHex:BF_COLOR_B15] forState:UIControlStateNormal];
    [self.onSaleBtn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.offSaleBtn setTitle:@"下架" forState:UIControlStateNormal];
    [self.offSaleBtn setTitleColor:[UIColor colorWithHex:BF_COLOR_B11] forState:UIControlStateNormal];
    [self.offSaleBtn addTarget:self action:@selector(offBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.middleSaleBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    [self.middleSaleBtn setTitle:@"上架" forState:UIControlStateNormal];
    self.middleSaleBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self.middleSaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.middleSaleBtn.layer.cornerRadius = 5;
    self.middleSaleBtn.clipsToBounds = YES;
    [self.middleSaleBtn addTarget:self action:@selector(middleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.onSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong"] forState:UIControlStateSelected];
    [self.offSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong_not"] forState:UIControlStateNormal];
    
    [self.onSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong_not"] forState:UIControlStateNormal];
    [self.offSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong"] forState:UIControlStateSelected];

}


- (void)configFoodImage:(NSString *)imageName foodName:(NSString *)nameStr foodPrice:(NSString *)price{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    self.FoodNameLable.text = nameStr;
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",price];
}

- (void)setSaleStatusWithOnSale:(BOOL)isOnSale{
    if (isOnSale) {
        [self.onSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong"] forState:UIControlStateNormal];
        [self.offSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong_not"] forState:UIControlStateNormal];
    }else{
        [self.onSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong_not"] forState:UIControlStateNormal];
        [self.offSaleBtn setImage:[UIImage imageNamed:@"cp_xuanzhong"] forState:UIControlStateNormal];
    }
}


- (void)hiddenSalesButton{
    self.onSaleBtn.hidden = YES;
    self.offSaleBtn.hidden = YES;
}

- (void)hiddenMiddleButton{
    self.middleSaleBtn.hidden = YES;
}


- (void)onBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(saleStatusBtnAction:andType:indesPath:)]) {
        [self.delegate saleStatusBtnAction:sender andType:@"on" indesPath:self.indexPath];
        
    }

}

- (void)offBtnClick:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(saleStatusBtnAction:andType:indesPath:)]) {
       [self.delegate saleStatusBtnAction:sender andType:@"off" indesPath:self.indexPath];
       
    }
}


- (void)middleBtnAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(middleBtnOnSaleAction:indesPath:)]) {
        [self.delegate middleBtnOnSaleAction:sender indesPath:self.indexPath];
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
