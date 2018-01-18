//
//  ZJFAddTagCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/12.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFAddTagCell.h"

@implementation ZJFAddTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.layer.borderWidth = 1;
        self.addButton.userInteractionEnabled = NO;
        self.addButton.layer.borderColor = [UIColor colorWithHex:@"#9489ff"].CGColor;
        [self addSubview:_addButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

        _addButton.frame = self.bounds;
    
}

@end
