//
//  LXBDidOrderHdView.h
//  01 点餐页面
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXBDidOrderHdView : UITableViewHeaderFooterView



//注册会在该方法内容做的 所以外部不需要注册的
+ (instancetype)headerInitialize:(UITableView *)tableView;

@property (nonatomic, copy) NSString *imgStr;
@property (nonatomic, copy) NSString *name;

@end
