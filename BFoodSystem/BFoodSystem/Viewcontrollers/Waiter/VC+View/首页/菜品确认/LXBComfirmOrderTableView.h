//
//  LXBComfirmOrderTableView.h
//  01 点餐页面
//
//  Created by binbin on 2017/4/14.
//  Copyright © 2017年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXBComfirmOrderTableView : UITableView

@property (nonatomic, strong) NSArray *dataListArr;

@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *desk_name;
@property (nonatomic, copy) NSString *dining_number;
@property (nonatomic, copy) NSString *payStatus;

- (void)configUI;

@end


@interface LXBConfirmtbHeadView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *headPayStatus;
@property (nonatomic, strong) UILabel *deskName;
@property (nonatomic, strong) UILabel *payShow;
//headView 自定义注册的方法,外面不需要再注册
+ (instancetype)headerInitialize:(UITableView *)tableView;

@end
