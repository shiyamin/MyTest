//
//  BFShopHeadView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/16.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    picImageType,
    picUrlType,
    picDefaultType,
} picType;

@protocol BFShopHeadViewDelegate <NSObject>

- (void)headViewPicItemAction:(NSIndexPath *)index;

- (void)headIconAction;

@end

@interface BFShopHeadView : UIView

@property(strong,nonatomic) UICollectionView *picCollectionView;

@property(strong,nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) id <BFShopHeadViewDelegate> delegate;

@property (nonatomic, strong)UITextField *shopTitleTF;

- (void)configIcon:(NSString *)iconName shopTitle:(NSString *)title;

- (void)configImage:(UIImage *)image;


- (void)configShopPicList:(NSArray *)picArr;

- (void)configShopPicListWithImageArr:(NSArray *)imageArr;

- (void)timerInvalidate;


@end
