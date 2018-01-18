//
//  BFFoodController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodController.h"
#import "BFFoodTableCell.h"
#import "BFAddFoodDetailController.h"
#import "BFRightBtn.h"
#import "BFOffSaleFoodController.h"
#import "BFFoodServices.h"
#import "BFFoodModel.h"
#import "BJNoDataView.h"

@interface BFFoodController ()<UITableViewDelegate,UITableViewDataSource,BFAddFoodDetailControllerDelegate,BFFoodTableCellDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation BFFoodController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 104) style:UITableViewStylePlain];
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
    self.title = @"菜品列表";
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    [self setStatusForSubViews];
    [self addBottomView];
    [self getFoodList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFoodList) name:updateFoodListNotification object:nil];

}

- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    BFRightBtn *navRightBtn = [[BFRightBtn alloc] init];
    [navRightBtn setRightBtnTitle:@"已下架" andTarget:self clickAction:@selector(btnAction:)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:navRightBtn]];
}

- (void)getFoodList{
    [[BFFoodServices alloc] getDishLishWithSuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        NSMutableArray *listArr = [NSMutableArray array];
        
        for (BFFoodModel *foodMdole in self.dataArr) {
            if ([foodMdole.is_shelf integerValue] == 1) {
                [listArr addObject:foodMdole];
            }
        }
        self.dataArr = listArr;
        [self.tabbleView reloadData];
        BFLog(@"self.dataArr====%@", self.dataArr);
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}


-(void)btnAction:(UIButton *)sender{
    BFOffSaleFoodController *offFoodVc = [[BFOffSaleFoodController alloc] init];
    [self.navigationController pushViewController:offFoodVc animated:YES];
}


- (void)addBottomView{
    UIButton *addClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addClassBtn setTitle:@"新增菜品" forState:UIControlStateNormal];
    [addClassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addClassBtn addTarget:self action:@selector(addClassAction:) forControlEvents:UIControlEventTouchUpInside];
    [addClassBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    addClassBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [self.view addSubview:addClassBtn];
    [addClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    if (iPhoneX) {
        [addClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-10);
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFFoodTableCellIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFFoodTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BFFoodTableCellIdentifier forIndexPath:indexPath];
    BFFoodModel *foodModel = self.dataArr[indexPath.row];
    [cell configFoodImage:foodModel.pic_url.firstObject foodName:foodModel.name foodPrice:foodModel.price];
    [cell hiddenMiddleButton];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setSaleStatusWithOnSale:[foodModel.is_shelf integerValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAddFoodDetailController *addVc = [[BFAddFoodDetailController alloc] init];
    BFFoodModel *foodModel = self.dataArr[indexPath.row];
    addVc.foodModel = foodModel;
    addVc.foodVcType = foodDetailChange;
    addVc.delegate = self;
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)addClassAction:(UIButton *)sender{
    
    BFAddFoodDetailController *addVc = [[BFAddFoodDetailController alloc] init];
    addVc.foodVcType = foodDetailNew;
    addVc.delegate = self;
    [self.navigationController pushViewController:addVc animated:YES];
}

- (void)saleStatusBtnAction:(UIButton *)statusBtn andType:(NSString *)typeStr indesPath:(NSIndexPath *)index{
    
    BFFoodTableCell *cell = [self.tabbleView cellForRowAtIndexPath:index];
    BFFoodModel *foodModel = self.dataArr[index.row];
    if ([typeStr isEqualToString:@"on"]) {
        
        UIAlertController * alert = [BFUtils alertController:nil message:@"确定上架？"];
        UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[BFFoodServices alloc] saveManyFoodOnSaleWithFoodIds:foodModel.foodId SuccessBlock:^(id result) {
                [BFUtils showAlertController:0 title:@"" message:@"上架成功"];
                [cell setSaleStatusWithOnSale:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:updateFoodListNotification object:nil];
                
            } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                [BFUtils showAlertController:0 title:@"" message:errorMessage];
                
            } Failure:^(NSError *error) {
                [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                
            }];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:confirm];
        [alert addAction:cancel];

        
    }else if ([typeStr isEqualToString:@"off"]){
        
        UIAlertController * alert = [BFUtils alertController:nil message:@"确定下架？"];
        UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[BFFoodServices alloc] delectManyFoodWithFoodIds:foodModel.foodId SuccessBlock:^(id result) {
                [BFUtils showAlertController:0 title:@"" message:@"下架成功"];
                [cell setSaleStatusWithOnSale:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:updateFoodListNotification object:nil];
                
            } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                [BFUtils showAlertController:0 title:@"" message:errorMessage];
                
            } Failure:^(NSError *error) {
                [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                
            }];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:confirm];
        [alert addAction:cancel];

    }
}

- (void)updataTabbleViewData{
    [self getFoodList];
}

#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tabbleView icon:nil iconClicked:^{
            //图片点击回调
            [self getFoodList];//刷新数据
        }];
        return;
    }
    //有数据
    [[BJNoDataView shareNoDataView] clear];
}
-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"dataArr"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
