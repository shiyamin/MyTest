//
//  BFAreaCollectionViewCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAreaCollectionViewCell.h"

@implementation BFAreaCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    [self.statusImageView setImage:[UIImage imageNamed:@"dm_xuanzhong_not"]];
    
}


- (void)setAreaName:(NSString *)name {
    self.lable.text = name;
}


- (void)setSelectStatus:(BOOL)isSelect{
    self.isSelect = isSelect;
    if (isSelect) {
        [self.statusImageView setImage:[UIImage imageNamed:@"dm_xuanzhong"]];
    }else{
        [self.statusImageView setImage:[UIImage imageNamed:@"dm_xuanzhong_not"]];
    }
}


@end
