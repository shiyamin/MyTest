//
//  UIImageView+ZJFCustomImageView.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "UIImageView+ZJFCustomImageView.h"

@implementation UIImageView (ZJFCustomImageView)

+ (instancetype)showNonDateImageWithAddView: (UIView *)view {
    UIImageView *showImageView = [[UIImageView alloc] initWithFrame:
                          CGRectMake(0, 0, 100, 100)];

//    showImageView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    if ((view.frame.size.width == 0)) {
        [view setFrame:CGRectMake(0, 100, WIDTH_SCREEN, HEIGHT_SCREEN-64)];
    }
//    if (view == nil) {
//        return nil;
//    }
    [showImageView setImage:[UIImage imageNamed:@"暂无数据"]];
    [showImageView setCenter:CGPointMake(view.frame.size.width / 2,
                                     view.frame.size.height / 2)];
    

    return showImageView;
}

//显示红点
- (void)showBadgeOnItmIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
//    UIView *bview = [[UIView alloc]init];
//    bview.tag = 888+index;
//    bview.layer.cornerRadius = 5;
//    bview.clipsToBounds = YES;
//    bview.backgroundColor = [UIColor redColor];
//    CGRect tabFram = self.frame;
//    
//    float percentX = (index+0.6)/TabbarItemNums;
//    CGFloat x = ceilf(percentX*tabFram.size.width);
//    CGFloat y = ceilf(0.1*tabFram.size.height);
//    bview.frame = CGRectMake(x, y, 10, 10);
//    [self addSubview:bview];
//    [self bringSubviewToFront:bview];
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [tipImageView setImage:[UIImage imageNamed:@"dian"]];
    [self addSubview:tipImageView];
    
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.width.height.mas_equalTo(20);
    }];

}
//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}
//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
