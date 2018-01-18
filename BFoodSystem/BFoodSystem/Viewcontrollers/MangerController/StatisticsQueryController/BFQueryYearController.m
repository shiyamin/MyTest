//
//  BFQueryYearController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryYearController.h"
#import "BFQueryYearCell.h"
#import "BFQueryServices.h"
#import "BFQueryDailyModel.h"

@interface BFQueryYearController ()<BFDataSearchViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)BFQueryDailyModel *dailyMdoel;

@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *endTime;


@end

@implementation BFQueryYearController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报表查询";
}


- (void)addSubviews{
    [self.dataView hiddenTipsLableAndImage];

    self.dataView.delegate = self;
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFQueryYearCell" bundle:nil] forCellReuseIdentifier:BFQueryYearCellIdentifier];
}

-(void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr{
    BFLog(@"%@====%@", beginStr,endStr);
    self.beginTime = beginStr;
    self.endTime = endStr;
    
    [BFUtils showProgressHUDWithTitle:@"查询中..." inView:self.view animated:YES];
    [[BFQueryServices alloc] queryStatisticsMonthWithStratTime:beginStr endTimeStr:endStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        self.dailyMdoel = (BFQueryDailyModel *)result;
        [self.tabbleView reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFQueryYearCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFQueryYearCell *cell = [tableView dequeueReusableCellWithIdentifier:BFQueryYearCellIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.clipsToBounds = YES;
    cell.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
    cell.layer.borderWidth = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dailyMdoel) {
        [cell configCellWtihMdoel:self.dailyMdoel];
        [cell configTitleWith:self.beginTime endTime:self.endTime];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
   
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
