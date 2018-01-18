//
//  BFTextFiledView.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFTextFiledView : UIView


@property (nonatomic, strong)UITextField *textfiled;
@property (nonatomic, strong)UIImageView *imageView;

- (void)configImage:(NSString *)imageStr textfiledPlaceholder:(NSString *)textplaceholder;


@end
