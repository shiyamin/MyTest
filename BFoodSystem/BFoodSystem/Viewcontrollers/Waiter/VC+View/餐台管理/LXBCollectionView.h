//
//  LXBCollectionView.h
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LXBCollectionView : UIView


@property (nonatomic, strong)NSArray *dataArr;

@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic, strong)NSString *eareName;
@end
