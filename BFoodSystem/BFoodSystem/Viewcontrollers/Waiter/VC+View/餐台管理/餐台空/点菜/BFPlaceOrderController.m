//
//  BFPlaceOrderController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//


#import "BFPlaceOrderController.h"
#import "BFAddFoodCell.h"
#import "BFOrderServices.h"
#import "BFFoodModel.h"

@interface BFPlaceOrderController ()<UITableViewDelegate,UITableViewDataSource,BFAddFoodCellDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, copy) NSString *remarkStr;

@end

@implementation BFPlaceOrderController

- (UITableView *)tabbleView{
    if (!_tabbleView ) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFAddFoodCell" bundle:nil] forCellReuseIdentifier:BFAddFoodCellIdentifier];
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
    self.title = @"确认下单";
    [self setStatusForSubViews];
    [self getCartList];
}


- (void)getCartList{
    
    [[BFOrderServices alloc] getCartListWithDeskId:self.deskModel.deskId WithSuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        [self.tabbleView reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
}



- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B11]];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.clipsToBounds = YES;
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset (-10);
        make.height.mas_equalTo(40);
    }];
    

}

- (void)updateTable{
    [self.tabbleView reloadData];
}

- (void)submitAction:(UIButton *)sender{
    
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"是否确认下单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
//    [alertVc addTextFieldWithConfigurationHandler:^(UITextField *textField){
//        textField.placeholder = @"请输入备注信息";
//    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UITextField *remarkTf = alertVc.textFields.firstObject;
//        self.remarkStr = remarkTf.text;
        [self saveOrderToServices];
        
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}


- (void)saveOrderToServices{
    
    [BFUtils showProgressHUDWithTitle:@"下单中..." inView:self.view animated:YES];
    [[BFOrderServices alloc] saveOrderWithDeskId:self.deskModel.deskId eatNum:self.eatNum remarkInfo:@"" SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        NSString *orderId = (NSString *)result;
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:updateWaiterDeskNotification object:nil];
        [self passOrderRequestWithOrderId:orderId];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    sectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-20, 40)];
    titleLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    titleLable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    titleLable.text = [NSString stringWithFormat:@"%@,用餐人数%@人",self.deskModel.name,self.eatNum];
    [sectionView addSubview:titleLable];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFAddFoodCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAddFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAddFoodCellIdentifier forIndexPath:indexPath];
    BFFoodModel *model = self.dataArr[indexPath.row];
    [cell configFoodName:model.name foodPrice:model.price foodNum:[NSString stringWithFormat:@"%ld",(long)model.buyNum]];
    [cell configFoodIcon:model.pic_url.firstObject];
    
    cell.delegate = self;
    cell.index = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)foodNumChangedWith:(NSIndexPath *)indexPath andFoodNum:(NSInteger)num isDelect:(BOOL)isAdd{
    BFFoodModel *foodModel = self.dataArr[indexPath.row];
    foodModel.buyNum = num;
    
    self.refreshBlock(isAdd);
    [[BFOrderServices alloc] cartSaveWithShelfId:foodModel.shelf_id withDeskID:self.deskModel.deskId andFoodNum:num SuccessBlock:^(id result) {
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];

}


- (void)passOrderRequestWithOrderId:(NSString *)orderNum{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd-HH:mm"];
    NSString *time = [format stringFromDate:nowDate];
    NSMutableArray *foodArr = [NSMutableArray array];
    for (BFFoodModel *model  in self.dataArr) {
        NSDictionary *foodDic = @{@"Name":model.name,@"Seat":[NSString stringWithFormat:@"%ld",(long)model.buyNum]};
        [foodArr addObject:foodDic];
    }
    NSDictionary *foodDic = @{@"Name":@"餐位",@"Seat":[NSString stringWithFormat:@"%@",self.eatNum]};
    [foodArr addObject:foodDic];
    [[BFOrderServices alloc] passMenuWithTableNum:self.deskModel.name printIp:[BFUserSignelton shareBFUserSignelton].printer_addr time:time orderNum:orderNum passOrderArr:foodArr remark:@"" SuccessBlock:^(id result) {
         [BFUtils showAlertController:0 title:@"" message:@"订单已送至厨房"];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];
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
