//
//  ZJFShowTagCell.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/12.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "ZJFShowTagCell.h"

@implementation ZJFShowTagCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.layer.borderWidth = 1;
        self.tagLabel.userInteractionEnabled = NO;
        self.tagLabel.textColor = [UIColor colorWithHex:@"#808080"];
        self.tagLabel.layer.borderColor = [UIColor colorWithHex:@"#9489ff"].CGColor;
        self.tagLabel.font = [UIFont systemFontOfSize:12];
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tagLabel];
        
        self.selectIgv = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.selectIgv];
    
       
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _tagLabel.frame = self.bounds;
    [_selectIgv setImage:[UIImage imageNamed:@"dm_shanchu"]];
    _selectIgv.frame = CGRectMake(self.bounds.size.width - 15, 0, 15, 15);
    
    
    
}
@end
