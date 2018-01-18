//
//  BFAddFoodClassController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAddFoodClassController.h"
#import "BFAddFoodClassCell.h"
#import "BFFoodServices.h"
#import "BFFoodClassModel.h"
#import "BFRightBtn.h"
#import "BJNoDataView.h"

@interface BFAddFoodClassController ()<UITableViewDataSource, UITableViewDelegate,BFAddFoodClassCellDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong) BFRightBtn *navRightBtn;

@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation BFAddFoodClassController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT- 104) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFAddFoodClassCell" bundle:nil] forCellReuseIdentifier:BFAddFoodClassCellIdentifier];
        _tabbleView.tableFooterView = [[UIView alloc] init];
        _tabbleView.separatorColor = [UIColor clearColor];
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
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
    self.title = @"商品分类管理";
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    [self setStatusForSubViews];
    [self addBottomView];
    [self getFoodClassList];
}

- (void)setStatusForSubViews{
    
    self.isEdit = NO;
    [self.view addSubview:self.tabbleView];
    self.navRightBtn = [[BFRightBtn alloc] init];
    [self.navRightBtn setRightBtnTitle:@"编辑" andTarget:self clickAction:@selector(btnAction:)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn]];

}


- (void)getFoodClassList{
    [[BFFoodServices alloc] getDishesListWtihSaleStatus:@"" SuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        [self.tabbleView reloadData];

    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
    
   
}

- (void)addBottomView{
    UIButton *addClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addClassBtn setTitle:@"新建分类" forState:UIControlStateNormal];
    [addClassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addClassBtn addTarget:self action:@selector(addClassAction:) forControlEvents:UIControlEventTouchUpInside];
    [addClassBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B11]];
    addClassBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [self.view addSubview:addClassBtn];
    [addClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

- (void)btnAction:(UIButton *)sender{
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        [self.navRightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [self.navRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [self.tabbleView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFAddFoodClassCellHeigh;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAddFoodClassCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAddFoodClassCellIdentifier forIndexPath:indexPath];
    BFFoodClassModel *model = self.dataArr[indexPath.row];
    cell.delegate = self;
    [cell setFoodClassName:model.name andLevel:model.sort delectBtnTag:indexPath.row];
    [cell hiddenDeleteBtn:self.isEdit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isEdit) {
        return;
    }
    BFFoodClassModel *foodModel = self.dataArr[indexPath.row];
    [self presentAlertViewControllerWithFoodName:foodModel.name foodLevel:[NSString stringWithFormat:@"%@",foodModel.sort] foodClassId:[NSString stringWithFormat:@"%@",foodModel.foodClassId]];
}

- (void)delectBtnAction:(UIButton *)btn index:(NSInteger)index{
    BFFoodClassModel *model = self.dataArr[index];

    [[BFFoodServices alloc] delectDishesTypeWithTypeId:model.foodClassId SuccessBlock:^(id result) {
        [BFUtils showAlertController:0 title:@"" message:@"成功删除分类"];
        [self getFoodClassList];
        [[NSNotificationCenter defaultCenter] postNotificationName:updateFoodListNotification object:nil];
    }errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}

- (void)addClassAction:(UIButton *)sender{
    [self presentAlertViewControllerWithFoodName:nil foodLevel:nil foodClassId:@""];
}



- (void)presentAlertViewControllerWithFoodName:(NSString *)nameStr foodLevel:(NSString *)levelStr foodClassId:(NSString *)classId{
    
    NSString *messageStr = @"新建分类";
    if (nameStr && ![nameStr isEqualToString:@""]) {
        messageStr = @"修改分类信息";
    }
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入分类名";
        if (nameStr && ![nameStr isEqualToString:@""]) {
            textField.text = nameStr;
        }
    }];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入分类等级";
        if (levelStr && ![levelStr isEqualToString:@""]) {
            textField.text = levelStr;
        }
    }];
    UIAlertAction *okAction =  [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSString *nameStr = alertVc.textFields.firstObject.text;
        NSString *levelStr = alertVc.textFields.lastObject.text;
        [[BFFoodServices alloc] saveDishesInfoWithName:nameStr sortLevel:levelStr dishesId:classId SuccessBlock:^(id result) {
            [BFUtils showAlertController:0 title:@"" message:[NSString stringWithFormat:@"%@成功",messageStr]];
            [self getFoodClassList];
            [[NSNotificationCenter defaultCenter] postNotificationName:updateFoodListNotification object:nil];
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
            
        } Failure:^(NSError *error) {
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
            
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVc addAction:okAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tabbleView icon:nil iconClicked:^{
            //图片点击回调
            [self getFoodClassList];//刷新数据
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
