//
//  BFDataSearchView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    beginTime,
    endTime,
} timeType;

@protocol BFDataSearchViewDelegate <NSObject>

- (void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr;

@end

@interface BFDataSearchView : UIView



@property (weak, nonatomic) IBOutlet UIView *beginBackView;

@property (weak, nonatomic) IBOutlet UIView *endBackView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@property (weak, nonatomic) IBOutlet UILabel *beginTimeTitle;



@property (weak, nonatomic) IBOutlet UILabel *endTimeTitle;


@property (weak, nonatomic) IBOutlet UILabel *beginTime;


@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *tipsLable;

@property (weak, nonatomic) IBOutlet UIImageView *tipsImageView;


@property (nonatomic, assign) id<BFDataSearchViewDelegate> delegate;


- (void)hiddenTipsLableAndImage;



@end
