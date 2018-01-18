//
//  BFWaiterSetController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/23.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterSetController.h"
#import "BFNewWaiterCell.h"
#import "BFWaiterAreaCell.h"
#import "BFUpImageController.h"
#import "BFUserServices.h"
#import "BFAreaModel.h"
#import "BFWaiterMangerController.h"

@interface BFWaiterSetController () <UITableViewDelegate,UITableViewDataSource,BFUpImageControllerDelegate,BFWaiterAreaCellDelegate>

@property (nonatomic, strong) UITableView *tabbleView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *iconId;
@property (nonatomic, strong)UIButton *headIcon;

@property (nonatomic, strong) BFNewWaiterCell *newsWaiterCell;

@property (nonatomic, copy) NSString *areaIds;
@property (nonatomic, copy) NSString *employId;
@property (nonatomic, copy) NSString *psw;

@property (nonatomic, assign) BOOL isChange;


@end

@implementation BFWaiterSetController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        _tabbleView.separatorColor = [UIColor clearColor];
        _tabbleView.showsVerticalScrollIndicator = NO;
        _tabbleView.showsHorizontalScrollIndicator = NO;
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

- (NSString *)areaIds{
    if (!_areaIds) {
        _areaIds = [NSString string];
    }
    return _areaIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitle];
    [self setStatusForSubviews];
    [self configEmployeeModel];
    [self calculationAreaIds];
}

- (void)configTitle{
    if (self.vcType == waiterSetTypeAddWaiter) {
        self.title = @"新增服务员";
    }else if (self.vcType == waiterSetTypeSetWaiter){
        self.title = @"编辑服务员";
    }else if (self.vcType == waiterSetTypeAddCashier){
        self.title = @"新增收银员";
    }else if (self.vcType == waiterSetTypeSetCashier){
        self.title = @"编辑收银员";
    }
}

- (void)configEmployeeModel{
    
//    self.isChange = NO;
    if (self.employeeMdoel) {
        self.iconId = self.employeeMdoel.headimgId;
        self.employId = self.employeeMdoel.employeeId;
        if (![self.employeeMdoel.headimg_url isEqualToString:@""]) {
            [self.headIcon sd_setImageWithURL:[NSURL URLWithString:self.employeeMdoel.headimg_url] forState:UIControlStateNormal];
        }
    }
}

- (void)setStatusForSubviews{
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFNewWaiterCell" bundle:nil] forCellReuseIdentifier:BFNewWaiterCellIdentifier];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFWaiterAreaCell" bundle:nil] forCellReuseIdentifier:BFWaiterAreaCellIdentifier];
    [self creatTableViewHeadView];
    [self creatTableViewFootView];
}

- (void)creatTableViewHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    headView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self.tabbleView setTableHeaderView:headView];
    
    self.headIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headIcon setImage:[UIImage imageNamed:@"xzdy_touxiang"] forState:UIControlStateNormal];
    [self.headIcon addTarget:self action:@selector(headIconAction:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.headIcon];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.top.equalTo(headView).offset(20);
        make.width.height.mas_equalTo(60);
    }];
    
    UILabel *promptLabe = [[UILabel alloc] init];
    promptLabe.text = @"点击设置头像";
    promptLabe.textAlignment = NSTextAlignmentCenter;
    promptLabe.textColor = [UIColor colorWithHex:BF_COLOR_B2];
    promptLabe.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    [headView addSubview:promptLabe];
    
    [promptLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headIcon.mas_bottom).offset(2);
        make.centerX.equalTo(self.headIcon.mas_centerX);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(21);
    }];
}

- (void)creatTableViewFootView{
    CGFloat footHeight = SCREEN_HEIGHT - BFNewWaiterCellHight  - BFWaiterAreaCellHeight - 174;
    if (IS_IPhone5) {
        footHeight = SCREEN_HEIGHT - BFNewWaiterCellHight  - BFWaiterAreaCellHeight - 74;
    }
    if (self.vcType == waiterSetTypeSetCashier || self.vcType == waiterSetTypeAddCashier) {
        footHeight = footHeight + BFWaiterAreaCellHeight;
    }
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footHeight)];
    footView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self.tabbleView setTableFooterView:footView];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(12);
        make.right.equalTo(footView).offset(-12);
        make.bottom.equalTo(footView.mas_bottom).offset(-20);
        make.height.mas_equalTo(40);
    }];
    if (self.vcType == waiterSetTypeSetWaiter || self.vcType == waiterSetTypeSetCashier){
        [footView addSubview:changeBtn];
        [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footView).offset(12);
            make.right.equalTo(footView).offset(-12);
            make.bottom.equalTo(submitBtn.mas_top).offset(-10);
            make.height.mas_equalTo(40);
        }];
    }

    NSArray *btnArr = @[submitBtn,changeBtn];
    for (UIButton *btn  in btnArr) {
        [btn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    }
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [changeBtn setTitle:@"删除" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [changeBtn addTarget:self action:@selector(changeBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)back{
    
     [self.view endEditing:YES];
    
    if ((self.isChange && self.vcType == waiterSetTypeSetWaiter) || (self.isChange && self.vcType == waiterSetTypeSetCashier)) {
//         if ((self.isChange && self.vcType == waiterSetTypeSetWaiter) || (self.isChange && self.vcType == waiterSetTypeSetCashier)) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self submitAction];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.vcType == waiterSetTypeAddWaiter ||self.vcType == waiterSetTypeSetWaiter) {
        return 2;
    }else if (self.vcType == waiterSetTypeAddCashier || self.vcType == waiterSetTypeSetCashier){
        return 1;
    }
    return 0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return BFNewWaiterCellHight;
    }else if (indexPath.row == 1){
        return BFWaiterAreaCellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BFNewWaiterCell *waiterCell = [tableView dequeueReusableCellWithIdentifier:BFNewWaiterCellIdentifier forIndexPath:indexPath];
        self.newsWaiterCell = waiterCell;
        waiterCell.changeBlo = ^{
            self.isChange = YES;
        };
        if (self.employeeMdoel) {
             [waiterCell.psdTf addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
            [waiterCell configPhoneTf:self.employeeMdoel.nickname psdTf:@"******" userNameTf:self.employeeMdoel.truename];
        }
        waiterCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return waiterCell;
    }else{
        BFWaiterAreaCell *areaCell = [tableView dequeueReusableCellWithIdentifier:BFWaiterAreaCellIdentifier forIndexPath:indexPath];
        areaCell.delegate = self;
        areaCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [areaCell getAreaInfoList:self.areaArr];
        return areaCell;
    }

    return nil;
}



- (void)headIconAction:(UIButton *)btn{
    BFUpImageController *upVc = [[BFUpImageController alloc] init];
    upVc.allowUploadNum = 1;
    upVc.delegate = self;
    upVc.vcIdentifier = @"iconUpload";
    [self.navigationController pushViewController:upVc animated:YES];
}

- (void)uploadImageDidFinshWithId:(NSString *)idStr identifier:(NSString *)identifier photoArr:(NSArray *)photoArr{
    if ([identifier isEqualToString:@"iconUpload"]) {
        self.isChange = YES;
        self.iconId = idStr;
        [self.headIcon setImage:photoArr.lastObject forState:UIControlStateNormal];
    }
}

- (void)getAreaIdsFromWaiterAreaCell:(NSString *)areaIds{
    self.isChange = YES;
    self.areaIds = areaIds;
}


- (void)calculationAreaIds{
    NSMutableString *areaIds = [NSMutableString string];
    for (int count = 0; count < self.areaArr.count ; count ++ ) {
        BFAreaModel *model = self.areaArr[count];
        if (model.isSelect) {
            if(count == self.areaArr.count -1){
                [areaIds appendString:[NSString stringWithFormat:@"%@",model.areaId]];
            }else{
                [areaIds appendString:[NSString stringWithFormat:@"%@,",model.areaId]];
            }
        }
    }
    self.areaIds = areaIds;
}

- (void)submitAction{
    
    [self.view endEditing:YES];
    
    if(![self checkFormat]){
        return;
    }
    
    if (!self.iconId || [[NSString stringWithFormat:@"%@",self.iconId] isEqualToString:@""]) {
//        [BFUtils showAlertController:0 title:@"" message:@"请上传头像"];
//        return;
        self.iconId = @"";
    }
    
    NSString *nickNameStr = self.newsWaiterCell.phoneNameTf.text;
    NSString *psdStr = @"";
    if (_psw) {
        psdStr = _psw;
    } else {
        psdStr = @"";
    }
    NSString *userName = self.newsWaiterCell.userNameTf.text;
    NSString *type = @"";
    NSString *employId = @"";
    NSString *promptStr = @"";
    if (self.vcType == waiterSetTypeAddWaiter) {
         type = @"2";
        promptStr = @"成功增加服务员";
    }else if (self.vcType == waiterSetTypeSetWaiter){
         type = self.employeeMdoel.loginType;
        employId = self.employId;
        promptStr = @"修改服务员信息成功";
        
    }else if (self.vcType == waiterSetTypeAddCashier){
         type = @"3";
        self.areaIds = @"";
        promptStr = @"成功增加收银员";
//        psdStr = self.newsWaiterCell.psdTf.text;
    }else if (self.vcType == waiterSetTypeSetCashier){
        type = self.employeeMdoel.loginType;
        self.areaIds = @"";
        employId = self.employId;
        promptStr = @"修改收银员信息成功";
    }
    [BFUtils showProgressHUDWithTitle:@"请求中...." inView:self.view animated:YES];

    [[BFUserServices alloc] saveEmployeeInfoWithNickName:nickNameStr employeeName:userName password:psdStr loginType:type headimgId:self.iconId employeeId:employId areaIds:self.areaIds SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:promptStr];
        self.isChange = NO;
        [self.waiterMangerVc getEmployeeList];
//        if (self.vcType == waiterSetTypeSetCashier || self.vcType == waiterSetTypeSetWaiter) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
//        }
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
    
}

#pragma mark -- UITextFieldChange
- (void)textFieldDidChangeValue:(UITextField *)textField {
    _psw = textField.text;
    
}

- (void)changeBtnAction:(UIButton *)sender{
    self.isChange = NO;
//    if(![self checkFormat]){
//        return;
//    }
     [self.view endEditing:YES];
    NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
    [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"确定需要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc setValue:buttonTitle forKey:@"attributedTitle"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [BFUtils showProgressHUDWithTitle:@"保存中..." inView:self.view animated:YES];
        [BFUtils showProgressHUDWithTitle:@"请求中...." inView:self.view animated:YES];
        [[BFUserServices alloc] delectEmployeeWithEmployeeId:self.employId SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            [self.waiterMangerVc getEmployeeList];
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        } Failure:^(NSError *error) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        }];
        
        
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];


    
}

- (BOOL)checkFormat{
    
//    if (self.newsWaiterCell.phoneNameTf.text.length != 11) {
//        [BFUtils showAlertController:0 title:@"" message:@"请输入正确的手机号码"];
//        return NO;
//    }
    if (self.newsWaiterCell.psdTf.text.length == 0) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入密码"];
        return NO;
    }
    if (self.newsWaiterCell.userNameTf.text.length == 0) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入用户姓名"];
        return NO;
    }
    if (!self.areaIds || [self.areaIds isEqualToString:@""]) {
        if (self.vcType == waiterSetTypeAddWaiter || self.vcType == waiterSetTypeSetWaiter) {
            [BFUtils showAlertController:0 title:@"" message:@"请选择区域"];
            return NO;
        }

    }
    return YES;
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
