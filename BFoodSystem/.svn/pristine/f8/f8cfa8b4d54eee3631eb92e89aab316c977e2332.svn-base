//
//  LXBDidOrderTbView.m
//  01 点餐页面
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 XM. All rights reserved.
//

#import "LXBDidOrderTbView.h"
#import "LXBDidOrderTableViewCell.h"
#import "LXBDidOrderHdView.h"
#import "LXBOrder_listModel.h"
#import "BFDeskModel.h"
static NSString *OrderCellID = @"orderCellID";

@interface LXBDidOrderTbView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation LXBDidOrderTbView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        [self registerClass:[LXBDidOrderTableViewCell class] forCellReuseIdentifier:OrderCellID];
    
    }
    return self;
}
- (void)setRevokeDataArr:(NSArray *)revokeDataArr
{
    _revokeDataArr = revokeDataArr;
    [self reloadData];
}


#pragma mark - tableView Delegate, DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.orderDataArr.count;
    }else {
        return self.revokeDataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXBDidOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellID forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXBDidOrderTableViewCell *orderCell = (LXBDidOrderTableViewCell *)cell;
    if (indexPath.section != 0) {
        orderCell.dishesModel = self.revokeDataArr[indexPath.row];
        orderCell.LXBCarTableCellType = 2;
    }else {
        orderCell.dishesModel = self.orderDataArr[indexPath.row];
		orderCell.showCart.editButtonAction = ^(NSString * dishesId){
            //如果实现了某个方法
            if ([_aletDelegate respondsToSelector:@selector(clickCartDelegateAction:)]) {
                
                [_aletDelegate clickCartDelegateAction:dishesId];
            }
		
		};
        orderCell.LXBCarTableCellType = 1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 80;
    }else {
//        return 110;
        LXBCookingdetailModel *model = self.revokeDataArr[indexPath.row];
        return model.cellHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LXBDidOrderHdView *orderhdview = [LXBDidOrderHdView headerInitialize:tableView];
    if (section == 0) {
        orderhdview.imgStr = @"xiadan";
        orderhdview.name = @"已下单的菜品";
        
        
    }
    if (section == 1) {
        orderhdview.imgStr = @"chexiao";
        orderhdview.name = @"已撤销的菜品";
    }
    return orderhdview;
}


@end
