//
//  BFShopMangerMiddleCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/17.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopMangerMiddleCell.h"

@implementation BFShopMangerMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)configAddress:(NSString *)address avgPrice:(NSString *)avgprice openTime:(NSString *)openTime tel:(NSString *)tel{
    self.addressTf.text  = address;
    self.averageTf.text = avgprice;
    self.timeTf.text = openTime;
    self.phoneTf.text = tel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
