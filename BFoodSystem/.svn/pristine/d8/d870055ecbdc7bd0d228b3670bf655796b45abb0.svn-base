//
//  UILabel+LXBCustomlabel.m
//  BFoodSystem
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "UILabel+LXBCustomlabel.h"

@implementation UILabel (LXBCustomlabel)



+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    if (labelText.length != 0) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        label.attributedText = attributedString;
        [label sizeToFit];
        
    }
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    if (labelText.length != 0) {

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        label.attributedText = attributedString;
        [label sizeToFit];
    }
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    if (labelText.length != 0) {

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        label.attributedText = attributedString;
        [label sizeToFit];
    }
}
+ (instancetype)showNonDateLabelWithAddView: (UIView *)view {
    UILabel *showLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(0, 0, 200, 40)];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    
        showLabel.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        showLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
        showLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.text = @"暂无数据";
        [showLabel setCenter:CGPointMake(view.frame.size.width / 2,
                                         view.frame.size.height / 2)];
        
//    });
    return showLabel;
}

@end
