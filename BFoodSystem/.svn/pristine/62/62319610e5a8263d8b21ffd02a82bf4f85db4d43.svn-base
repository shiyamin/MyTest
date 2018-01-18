//
//  BFDeskMangerCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskMangerCell.h"

@implementation BFDeskMangerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSubviewsStatus];
}

- (void)setSubviewsStatus{
    self.deskTileLab.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
    self.deskTileLab.layer.cornerRadius = 11;
    self.deskTileLab.clipsToBounds = YES;
    self.deskTileLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.deskTileLab.textColor = [UIColor whiteColor];
    
    self.personNumLab.text = @"可容纳人数：-";
    self.personNumLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.personNumLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    
    self.deskTypeLab.text = @"餐桌类型：-";
    self.deskTypeLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.deskTypeLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];

    self.waiterNameLab.text = @"服务员：-";
    self.waiterNameLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    self.waiterNameLab.textColor = [UIColor colorWithHex:BF_COLOR_B4];

    
}

- (void)configDeskMangerCellWithDeskName:(NSString *)deskName PersonNum:(NSString *)personNumStr deskType:(NSString *)deskTypeStr waiterName:(NSArray *)nameArr{
    
    self.deskTileLab.text = deskName;
    self.personNumLab.text = [NSString stringWithFormat:@"可容纳人数：%@",personNumStr];
    self.deskTypeLab.text = [NSString stringWithFormat:@"餐桌类型：%@",deskTypeStr];
    NSMutableString *name = [NSMutableString stringWithString:@"服务员："];
    if (nameArr.count != 0) {
        for (NSInteger count = 0 ;count < nameArr.count; count ++) {
            NSDictionary *nameDic = nameArr[count];
            if (count == nameArr.count -1) {
                [name appendString:[nameDic objectForKey:@"truename"]];
            }else{
                [name appendString:[NSString stringWithFormat:@"%@,",[nameDic objectForKey:@"truename"]]];
            }
        }
    }
    self.waiterNameLab.text = name;
}












- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
