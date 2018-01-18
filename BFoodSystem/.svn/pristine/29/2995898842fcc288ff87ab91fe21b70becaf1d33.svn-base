//
//  BFDeskSelectView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFDeskSelectViewDelegate <NSObject>

- (void)viewDidSelected:(NSString *)viewIdentifier;

@end

@interface BFDeskSelectView : UIView


@property (nonatomic, copy) NSString *viewIdentifier;

@property (nonatomic, assign) id <BFDeskSelectViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *titleImageView;


- (void)configBackGroundImage:(NSString *)imageName titleImage:(NSString *)titleImgName;

- (void)setTitleImageViewFrame;

@end
