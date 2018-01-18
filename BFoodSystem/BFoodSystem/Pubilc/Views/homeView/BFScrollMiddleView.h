//
//  BFScrollMiddleView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/15.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFScrollMiddleView : UIView


@property (weak, nonatomic) IBOutlet UILabel *saleTitleLable;


@property (weak, nonatomic) IBOutlet UILabel *saleNumLable;


@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *leftNumLab;

@property (weak, nonatomic) IBOutlet UILabel *orderTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;


@property (weak, nonatomic) IBOutlet UILabel *rightTitleLab;


@property (weak, nonatomic) IBOutlet UILabel *rightNumLab;



- (void)configInfoWithSaleNum:(NSString *)saleNumStr personNum:(NSString *)personNum orderNum:(NSString *)orderStr rightNum:(NSString *)rightStr;




@end
