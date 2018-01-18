//
//  BFHomeMangerCollectionCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/15.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFHomeMangerCollectionCellIndetifier @"BFHomeMangerCollectionCellIndetifier"


@interface BFHomeMangerCollectionCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopContras;

- (void)configMangerCellWithImageName:(NSString *)imageName titleName:(NSString *)titleStr;



@end
