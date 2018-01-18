//
//  BFTopLeftLabel.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFTopLeftLabel.h"

@implementation BFTopLeftLabel

- (id)initWithFrame:(CGRect)frame {

    return [super initWithFrame:frame];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y+5;
    
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
