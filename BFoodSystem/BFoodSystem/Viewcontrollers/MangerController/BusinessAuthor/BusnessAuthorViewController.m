//
//  BusnessAuthorViewController.m
//  BFoodSystem
//
//  Created by 浙江择富 on 2018/1/17.
//  Copyright © 2018年 陈名正. All rights reserved.
//

#import "BusnessAuthorViewController.h"
#import "BFBusinessAuthorTableViewCell.h"
#import "BFBusinessHeadView.h"

@interface BusnessAuthorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong)BFBusinessHeadView *BFHeadView;
//@property (nonatomic, strong)BFBusinessHeadView *footerView;

@end

@implementation BusnessAuthorViewController
- (NSArray *)nameArr{
    if (!_nameArr) {
        _nameArr = @[@"身份证正面：",@"身份证反面：",@"营业执照：",@"特殊行业许可证：",@"店面门头照：",@"店内前台场景照：",@"店内营业场景照：",@"店内营业场景照：",@"公司结算账户授权书：",@"移动支付业务商户协议书："];
    }
    return _nameArr;
}

//**区头视图*/
- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-20, 60*4)];
         _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

//**区脚视图*/
- (UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8*60+45)];
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {

        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title  = @"商家认证";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
        
    }];
    [self.tableView registerClass:[BFBusinessAuthorTableViewCell class] forCellReuseIdentifier: BFBusinessAuthorCellIndetifier];
    
    [self headView];
    [self footView];
 
}
//区头视图
- (void)headView{
    NSArray *nameArr = @[@"真实名称：",@"商户简称：",@"身份证号码：",@"详细地址："];
    
    NSArray *placeHolderArr = @[@"请输入真实名称",@"请输入商户简称",@"请输入身份证号",@"请输入详细地址"];
    
    for (int i = 0; i<nameArr.count; i++) {
        
        _BFHeadView = [[BFBusinessHeadView alloc] initWithFrame:CGRectMake(0, i*60, SCREEN_WIDTH-20*2, 60)];
        //        BFHeadView.backgroundColor = [UIColor redColor];
        
        _BFHeadView.nameLab.text = nameArr[i];
        _BFHeadView.tf.placeholder = placeHolderArr[i];
        [self.headerView addSubview:_BFHeadView];
    }
    self.tableView.tableHeaderView = self.headerView;
    
    
}
//区脚视图
- (void)footView{

    NSArray *contentArr = @[@"营业执照号：",@"银行卡号：",@"开户姓名：",@"开户支行：",@"手机号：",@"邮箱号："];
    
    NSArray *placeArr = @[@"请输入营业执照号",@"请输入银行卡号",@"请输入开户姓名",@"请输入开户行",@"请输入手机号",@"请输入邮箱"];
    
    for (int i = 0; i<contentArr.count; i++) {
        
       _BFHeadView = [[BFBusinessHeadView alloc] initWithFrame:CGRectMake(0, i*60, SCREEN_WIDTH-20*2, 60)];
        //        BFHeadView.backgroundColor = [UIColor redColor];
        
        _BFHeadView.nameLab.text = contentArr[i];
        _BFHeadView.tf.placeholder = placeArr[i];
        [self.footerView addSubview:_BFHeadView];
    }
    

    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.commitBtn.backgroundColor = [UIColor redColor];
    self.commitBtn.layer.cornerRadius = 8;
    [self.commitBtn setTintColor:[UIColor colorWithHex:BF_COLOR_B0]];
    [self.footerView addSubview:self.commitBtn];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.footerView).offset(-45);
        make.left.equalTo(self.footerView).offset(20);
         make.right.equalTo(self.footerView).offset(-20);
        make.height.mas_equalTo(60);
    }];
    [self.commitBtn addTarget:self action:@selector(commitBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footerView;
}
   //**提交审核认证信息*/
- (void)commitBtn:(UIButton *)btn{
    
    BFLog(@"=======%@", @"点击提交审核信息");
}
#pragma 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       BFBusinessAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BFBusinessAuthorCellIndetifier forIndexPath:indexPath];
    
    cell.nameLab.text = self.nameArr[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60*4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8*60+45;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return _headerView;
//}
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
