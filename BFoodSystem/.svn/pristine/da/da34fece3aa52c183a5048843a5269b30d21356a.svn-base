//
//  BFWaiterMangerController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/22.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterMangerController.h"
#import "BFWaiterTableCell.h"
#import "BFWaiterMangerHeadView.h"
#import "BFWaiterSetController.h"
#import "BFUserServices.h"
#import "BFEmployeeModel.h"
#import "BFAreaModel.h"


@interface BFWaiterMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic, strong)NSMutableArray  *areaArr;

@end

@implementation BFWaiterMangerController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
        _tabbleView.tableFooterView = footView;
        _tabbleView.separatorColor = [UIColor clearColor];
    }
    return _tabbleView;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)areaArr{
    if (!_areaArr) {
        _areaArr = [NSMutableArray array];
    }
    return _areaArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店员管理";
    [self creatSubviewStatus];
    [self getEmployeeList];
}


- (void)creatSubviewStatus{
    
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFWaiterTableCell" bundle:nil] forCellReuseIdentifier:BFWaiterTableCellIdentifier];
    self.tabbleView.estimatedRowHeight = 140;
    self.tabbleView.rowHeight =UITableViewAutomaticDimension;
}

- (void)getEmployeeList{
    [[BFUserServices alloc] getEmployeeListWithSuccessBlock:^(id result) {
        NSArray *resultArr = (NSArray *)result;
        NSMutableArray *waiterArr = [NSMutableArray array];
        NSMutableArray *cashierArr = [NSMutableArray array];
        for (BFEmployeeModel *model in resultArr.firstObject) {
            if ([model.loginType integerValue] == 3) {
                [cashierArr addObject:model];
            }else{
                [waiterArr addObject:model];
            }
        }
        [self.dataArr removeAllObjects];
        [self.dataArr addObject:cashierArr];
        [self.dataArr addObject:waiterArr];
        [self.tabbleView reloadData];
        self.areaArr = resultArr.lastObject;
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return BFWaiterTableCellHeight;
    }else{
        NSArray *modelArr = self.dataArr[indexPath.section];
        BFEmployeeModel *model = modelArr[indexPath.row];
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:[self caculatePositionStr:model.area_ids]];
        return 80 + calculateAttributedTextHeightForWidth(attri, SCREEN_WIDTH - 100);
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BFWaiterMangerHeadView *headView = [[BFWaiterMangerHeadView alloc] init];
    if (section== 0) {
        [headView configBackgroundView:@"dy_shouyinyuan" imageview:@"" titileInfo:@""];
    }else{
        [headView configBackgroundView:@"dy_fuwuyuan" imageview:@"" titileInfo:@""];
    }
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:btn];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    btn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    btn.layer.cornerRadius = 15;
    btn.clipsToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.tag = section;
    if (section == 0) {
        [btn setTitle:@"新增收银员" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"新增服务员" forState:UIControlStateNormal];
    }
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.centerY.equalTo(backView.mas_centerY);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    [btn setImage:[UIImage imageNamed:@"dy_tianjia"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 130)];
    [btn addTarget:self action:@selector(addPersonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return backView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFWaiterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BFWaiterTableCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHex:BF_COLOR_B10];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *modelArr = self.dataArr[indexPath.section];
    BFEmployeeModel *model = modelArr[indexPath.row];
    [cell configPersonName:model.truename personOpsition:[self caculatePositionStr:model.area_ids] headIcon:model.headimg_url loginType:[model.loginType integerValue]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *modelArr = self.dataArr[indexPath.section];
    BFEmployeeModel *model = modelArr[indexPath.row];
    BFWaiterSetController *waiterSetVc = [[BFWaiterSetController alloc] init];
    waiterSetVc.employeeMdoel = model;
    if ([model.loginType integerValue] == 3) {
        waiterSetVc.vcType = waiterSetTypeSetCashier;
    }else{
        waiterSetVc.vcType = waiterSetTypeSetWaiter;
        for (BFAreaModel *areaModel in self.areaArr) {
            areaModel.isSelect = NO;
            for (NSDictionary *dic in model.area_ids) {
                if ([[dic objectForKey:@"id"] integerValue] == [areaModel.areaId integerValue]) {
                    areaModel.isSelect = YES;
                }
            }
            [waiterSetVc.areaArr addObject:areaModel];
        }

    }
    waiterSetVc.waiterMangerVc = self;
    [self.navigationController pushViewController:waiterSetVc animated:YES];
}


- (void)addPersonBtnClick:(UIButton *)sender{
    BFWaiterSetController *waiterSetVc = [[BFWaiterSetController alloc] init];
    if (sender.tag == 0) {
        waiterSetVc.vcType = waiterSetTypeAddCashier;
    }else{
        if (self.areaArr.count == 0) {
            [BFUtils showAlertController:0 title:@"" message:@"暂无区域选择，请新增区域。"];
            return ;
        }
        waiterSetVc.vcType = waiterSetTypeAddWaiter;
        for (BFAreaModel *areaModel in self.areaArr) {
            areaModel.isSelect = NO;
            [waiterSetVc.areaArr addObject:areaModel];
        }
    }
    waiterSetVc.waiterMangerVc = self;
    [self.navigationController pushViewController:waiterSetVc animated:YES];
}

- (NSString *)caculatePositionStr:(NSArray *)array{
    NSMutableString *str = [NSMutableString stringWithString:@"负责区域："];
    for (NSInteger count = 0; count < array.count ; count ++) {
        NSDictionary *areaDic = [array objectAtIndex:count];
        if (count == array.count -1) {
            [str appendString:[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]]];
        }else{
            [str appendString:[NSString stringWithFormat:@"%@,",[areaDic objectForKey:@"name"]]];
        }
    }
    return str;

}
- (void)dealloc {
    BFLog(@"%s", __func__);
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
