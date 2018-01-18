//
//  BFOffSaleFoodController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/29.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFOffSaleFoodController.h"
#import "BFFoodTableCell.h"
#import "BFFoodSectionView.h"
#import "BFFoodServices.h"
#import "BFFoodClassModel.h"
#import "BFFoodSaleModel.h"
#import "BFFoodServices.h"

@interface BFOffSaleFoodController ()<UITableViewDelegate,UITableViewDataSource,BFFoodTableCellDelegate>


@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation BFOffSaleFoodController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFFoodTableCell" bundle:nil] forCellReuseIdentifier:BFFoodTableCellIdentifier];
        _tabbleView.tableFooterView = [[UIView alloc] init];
    }
    return _tabbleView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已下架菜品";
    [self setStatusForSubViews];
    [self getOffSaleFoodList];
}

- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    
}


- (void)getOffSaleFoodList{
    
    [[BFFoodServices alloc] getDishesListWtihSaleStatus:@"0" SuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        [self.tabbleView reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFFoodClassModel *classModel = self.dataArr[section];
    return [classModel.dishesArr count];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFFoodTableCellIHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BFFoodSectionView *secView = [[BFFoodSectionView alloc] init];
    [secView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    BFFoodClassModel *classModel = self.dataArr[section];
    [secView congfigSectionHeadInfo:classModel.name];
    return secView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFFoodTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BFFoodTableCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    BFFoodClassModel *classModel = self.dataArr[indexPath.section];
    [cell hiddenSalesButton];
    BFFoodModel *foodModel = classModel.dishesArr[indexPath.row];
    [cell configFoodImage:foodModel.pic_url.firstObject foodName:foodModel.name foodPrice:foodModel.price];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)middleBtnOnSaleAction:(UIButton *)sender indesPath:(NSIndexPath *)index{
    BFFoodClassModel *classModel = self.dataArr[index.section];
    BFFoodModel *saleModel = classModel.dishesArr[index.row];
    
    [BFUtils showProgressHUDWithTitle:@"请求中..." inView:self.view animated:YES];
    [[BFFoodServices alloc] saveManyFoodOnSaleWithFoodIds:saleModel.foodId SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"上架成功"];
        [classModel.dishesArr removeObjectAtIndex:index.row];
        [self.tabbleView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:updateFoodListNotification object:nil];

    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];

}
- (void)dealloc {
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
