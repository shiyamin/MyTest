//
//  BFHomeMangerCollectionCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/15.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFHomeMangerCollectionCell.h"

@implementation BFHomeMangerCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (IS_IPhone6plus) {
        [self.imageTopContras setConstant:14];
    }
}

- (void)configMangerCellWithImageName:(NSString *)imageName titleName:(NSString *)titleStr{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.nameLable.text = titleStr;
}




@end
