//
//  LXBDidOrderHdView.m
//  01 点餐页面
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 XM. All rights reserved.
//

#import "LXBDidOrderHdView.h"

@interface LXBDidOrderHdView ()
@property (nonatomic, strong) UIImageView *leftimgView;
@property (nonatomic, strong) UILabel *titleName;
@end

@implementation LXBDidOrderHdView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerInitialize:(UITableView *)tableView
{
    static NSString *headID = @"lxbDidOrderHearderID";
    LXBDidOrderHdView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
    if (headerView == nil) {
        headerView = [[LXBDidOrderHdView alloc]  initWithReuseIdentifier:headID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
        return self;
}

- (void)createUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
	UIImageView *imgView = [[UIImageView alloc] init];
	[self.contentView addSubview:imgView];
	[imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.contentView.mas_left).with.offset(10);
		make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
		make.height.mas_offset(@18);
		make.width.mas_offset(@18);
	}];
	self.leftimgView = imgView;
	UILabel *title = [[UILabel alloc] init];
	[title setFont:[UIFont systemFontOfSize:14]];
	[self.contentView addSubview:title];
	[title mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(imgView.mas_right).with.offset(3);
		make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
		make.height.mas_equalTo(@18);
		make.right.equalTo(self.contentView.mas_right).with.offset(0);
		
	}];
	
	self.titleName = title;


}

- (void)setName:(NSString *)name
{
    _name = name;
    self.titleName.text = _name;
}

- (void)setImgStr:(NSString *)imgStr
{
    _imgStr = imgStr;
    self.leftimgView.image = [UIImage imageNamed:_imgStr];
}
@end
