//
//  BFQueryTodayController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryTodayController.h"
#import "BFQueryTodayCell.h"
#import "BFQueryServices.h"
#import "BJNoDataView.h"


@interface BFQueryTodayController ()<BFDataSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation BFQueryTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"单日流水查询";
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];

}


- (void)addSubviews{
    self.dataView.delegate = self;
    [self.view addSubview:self.tabbleView];
    self.tabbleView.showsVerticalScrollIndicator = NO;
    self.tabbleView.showsHorizontalScrollIndicator = NO;
    [self.dataView hiddenTipsLableAndImage];
    
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFQueryTodayCell" bundle:nil] forCellReuseIdentifier:BFQueryTodayCellIdentifier];

}

-(void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr{
    BFLog(@"%@====%@", beginStr,endStr);
    
    [BFUtils showProgressHUDWithTitle:@"查询中..." inView:self.view animated:YES];
    [[BFQueryServices alloc] queryStatisticsDailyWithStartTime:beginStr endTime:endStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        self.dataArr = (NSMutableArray *)result;
//        if ([self.dataArr isKindOfClass:[NSMutableArray class]]
//            && self.dataArr.count == 0) {
//            _showImageView = [UIImageView showNonDateImageWithAddView:self.tabbleView];
//            [_showImageView removeFromSuperview];
//            [self.tabbleView addSubview:_showImageView];
//        } else if (self.dataArr.count > 0) {
//            [_showImageView removeFromSuperview];
//            
//        }
        [self.tabbleView  reloadData];    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFQueryTodayCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFQueryTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:BFQueryTodayCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFQueryDailyModel *dailyModel = self.dataArr[indexPath.row];
    if (indexPath.row == 0) {
        [cell setBackgroundIamge:@"cx_t"];
    }else{
        [cell setBackgroundIamge:@"cx_d"];
    }
    [cell configCellWithDailyModel:dailyModel];
    return cell;
}
#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tabbleView icon:nil iconClicked:^{
            //图片点击回调
//            [self getAreaListInfo];//刷新数据
        }];
        return;
    }
    //有数据
    [[BJNoDataView shareNoDataView] clear];
}
-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"dataArr"];
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
