//
//  BFAddFoodController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/10.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAddFoodController.h"
#import "BFAddFoodCell.h"
#import "BFFoodSectionView.h"
#import "BFFoodClassPopController.h"
#import "BFAddFoodClassController.h"
#import "BFFoodServices.h"
#import "BFFoodClassModel.h"
#import "BFFoodModel.h"
#import "BFPlaceOrderController.h"
#import "BFOrderServices.h"
#import "BFFoodSearchController.h"
#import "BFSearchTextField.h"
#import "UIButton+BFRedButton.h"
#import "BJNoDataView.h"


@interface BFAddFoodController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,BFFoodClassPopControllerDelegate,BFAddFoodCellDelegate>{
    BFSearchTextField *searchField;
}

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *searchArr;

@property (nonatomic, strong) UILabel *badgeLable;

@property (nonatomic, assign)NSInteger badge;

@property (nonatomic, assign) BOOL isInSearch;

@end

@implementation BFAddFoodController


- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStylePlain];
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

- (NSMutableArray *)searchArr{
    if (!_searchArr) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    self.title = @"点菜";
    self.badge = 0;
    self.isInSearch = NO;
    [self setStatusForSubViews];
    [self getFoodList];
    
   
}


- (void)back{
    [self.view endEditing:YES];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"退出会清空下单菜品数据，是否确认？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[BFOrderServices alloc] clearCartOrderListSuccessBlock:^(id result) {
            
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            
        } Failure:^(NSError *error) {
            
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:okAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


- (void)setStatusForSubViews{
    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"sy_sousuo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction)];
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self.view addSubview:self.tabbleView];
    
    UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.tag = 1;
    UIButton *foodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    foodBtn.tag = 2;
    NSArray *btnArr = @[classBtn,foodBtn];
    for (UIButton *btn in btnArr) {
        btn.layer.cornerRadius = btn.frame.size.width/2;
        btn.clipsToBounds = YES;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.width.height.mas_equalTo(60);
        make.centerX.equalTo(self.view).offset(-40);
    }];
    [foodBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(classBtn);
        make.centerX.equalTo(self.view).offset(40);
    }];
    
    UILabel *badgeLab = [[UILabel alloc] init];
    badgeLab.textAlignment = NSTextAlignmentCenter;
    badgeLab.text = @"1";
    badgeLab.textColor = [UIColor whiteColor];
    badgeLab.backgroundColor = [UIColor colorWithHex:BF_COLOR_B11];
    badgeLab.layer.cornerRadius = 12;
    badgeLab.clipsToBounds = YES;
    [self.view addSubview:badgeLab];
    [badgeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(foodBtn);
        make.top.equalTo(foodBtn);
        make.width.height.mas_equalTo(24);
    }];
    self.badgeLable = badgeLab;
    self.badgeLable.hidden = YES;
    
    UIView *headSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headSearchView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    self.tabbleView.tableHeaderView = headSearchView;
    
    searchField = [BFSearchTextField searchBarWithTitle:@"请输入菜品名搜索" withImage:@"sy_sousuo"];
    [headSearchView addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headSearchView.mas_left).offset(15);
        make.top.mas_equalTo(headSearchView).offset(10);
        make.right.mas_equalTo(headSearchView).offset(-15);
        make.height.mas_equalTo(30);
    }];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.delegate = self;
    
    
    //搜索的but
    UIButton *searchBut = [UIButton configUniversalWithTitle:@"取消" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B10 withBgImage:nil withBgColor:nil];
    [searchBut addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [headSearchView addSubview:searchBut];
    [searchBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headSearchView).offset(10);
        make.right.mas_equalTo(headSearchView).with.offset(-15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    searchBut.layer.borderWidth = 1.0;
    searchBut.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
    searchBut.layer.cornerRadius = 5.0;
    
    [classBtn setImage:[UIImage imageNamed:@"cd_fenlei"] forState:UIControlStateNormal];
    [foodBtn setImage:[UIImage imageNamed:@"dc_xiadan"] forState:UIControlStateNormal];
    
}

//- (void)rightBtnAction{
//    BFFoodSearchController *foodVc = [[BFFoodSearchController alloc] init];
//    foodVc.dataArr = self.dataArr;
//    [self.navigationController pushViewController:foodVc animated:YES];
//}

- (void)getFoodList{
    
    [[BFFoodServices alloc] getDishesListWtihSaleStatus:@"1" SuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        [self.searchArr addObjectsFromArray:(NSArray *)result];
        [self.tabbleView reloadData];
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
    
    
    
}


- (void)searchAction:(UIButton *)sender{
    [searchField resignFirstResponder];
    self.isInSearch = NO;
    searchField.text = @"";
    [self.tabbleView reloadData];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    if ([searchField.text isEqualToString:@""]) {
//        [self.searchArr addObjectsFromArray: self.dataArr];
        self.isInSearch = NO;

    }else{
        self.isInSearch = YES;
        [self.searchArr removeAllObjects];
        for (BFFoodClassModel *classModel in self.dataArr) {
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchField.text];
            NSArray *result = [classModel.dishesArr filteredArrayUsingPredicate:pred];
            BFLog(@"pre====%@   searchText == %@", result, searchField.text);
            [self.searchArr addObjectsFromArray:result];
        }
        for (NSInteger count = 0; count < self.searchArr.count; count ++) {
            BFFoodModel *foodModelOne = self.searchArr[count];
            
            for (NSInteger next=count+1; next< self.searchArr.count ;) {
                BFFoodModel *foodModelTwo = self.searchArr[next];
                if ([foodModelOne.name isEqualToString:foodModelTwo.name]) {
                    [self.searchArr removeObject:foodModelTwo];
                }else{
                    next ++;
                }
            }
        }
    }
    
    [self.tabbleView reloadData];
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isInSearch) {
        return 1;
    }
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isInSearch) {
        return self.searchArr.count;
    }
    BFFoodClassModel *classModel = self.dataArr[section];
    return [classModel.dishesArr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFAddFoodCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isInSearch) {
        return 0;
    }
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
    BFAddFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAddFoodCellIdentifier forIndexPath:indexPath];
    if (self.isInSearch) {
        BFFoodModel *foodModel = self.searchArr[indexPath.row];
        [cell configFoodName:foodModel.name foodPrice:foodModel.price foodNum:[NSString stringWithFormat:@"%ld",(long)foodModel.buyNum]];
        [cell configFoodIcon:foodModel.pic_url.firstObject];
    }else{
        BFFoodClassModel *classModel = self.dataArr[indexPath.section];
        BFFoodModel *foodModel = classModel.dishesArr[indexPath.row];
        [cell configFoodName:foodModel.name foodPrice:foodModel.price foodNum:[NSString stringWithFormat:@"%ld",(long)foodModel.buyNum]];
        [cell configFoodIcon:foodModel.pic_url.firstObject];
    }

    cell.delegate = self;
    cell.index = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)foodNumChangedWith:(NSIndexPath *)indexPath andFoodNum:(NSInteger)num isDelect:(BOOL)isAdd{
    
    [self setBadgeWithAddStatus:isAdd];
    //修改bug
   	BFFoodModel * foodModel = nil;
    if (_isInSearch) {
        foodModel = self.searchArr[indexPath.row];
        foodModel.buyNum = num;
        
    }else{
        BFFoodClassModel *classModel = self.dataArr[indexPath.section];
        foodModel = classModel.dishesArr[indexPath.row];
        foodModel.buyNum = num;
    }
    
    [[BFOrderServices alloc] cartSaveWithShelfId:foodModel.shelf_id withDeskID:self.deskModel.deskId andFoodNum:num SuccessBlock:^(id result) {
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        
    } Failure:^(NSError *error) {
        
    }];

    
    
}

- (void)setBadgeWithAddStatus:(BOOL)isAdd{
    if (isAdd) {
        self.badge++;
    }else{
        self.badge --;
    }
    self.badgeLable.text = [NSString stringWithFormat:@"%ld",(long)self.badge];
    if (self.badge>0) {
        self.badgeLable.hidden = NO;
    }else{
        self.badgeLable.hidden = YES;
    }
}

- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 1) {
        BFFoodClassPopController *foodClassVc = [[BFFoodClassPopController alloc] init];
        foodClassVc.modalPresentationStyle = UIModalPresentationPopover;
        foodClassVc.popoverPresentationController.delegate = self;
        foodClassVc.popoverPresentationController.sourceView = sender;
        foodClassVc.popoverPresentationController.sourceRect = CGRectMake(0, 0, sender.bounds.size.width -60, sender.bounds.size.height) ;//箭头位置
        foodClassVc.popoverPresentationController.backgroundColor = [UIColor clearColor];
        foodClassVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        foodClassVc.delegate = self;
        foodClassVc.vcIdentifier = @"addFood";
        [foodClassVc updateAreaWithDataArr:self.dataArr];
        [self presentViewController:foodClassVc animated:YES completion:nil];
    }else if (sender.tag == 2){
        BFPlaceOrderController *orderVc = [[BFPlaceOrderController alloc] init];
        
        for (BFFoodClassModel *classModel in self.dataArr) {
            for (BFFoodModel *foodModel in classModel.dishesArr) {
                if(foodModel.buyNum != 0 ){
                    [orderVc.dataArr addObject:foodModel];
                }
            }
        }
        [orderVc updateTable];
        orderVc.eatNum = self.eatPersonNum;
        orderVc.deskModel = self.deskModel;
        WS(weakSelf);
        orderVc.refreshBlock = ^(BOOL isAdd) {
            [weakSelf.tabbleView reloadData];
            [weakSelf setBadgeWithAddStatus:isAdd];
        };
        [self.navigationController pushViewController:orderVc animated:YES];
    }
}

- (void)didSelectRowAtIndex:(NSIndexPath *)index andSelectType:(NSString *)type{
    if (self.isInSearch) {
        return ;
    }
    if ([type isEqualToString:@"new"]) {
        BFAddFoodClassController *adFoodVc = [[BFAddFoodClassController alloc] init];
        [self.navigationController pushViewController:adFoodVc animated:YES];
    }else{
        
        BFFoodClassModel *classModel = self.dataArr[index.row];
        // 处理分类没有菜品时候
        if (classModel.dishesArr.count) {
            NSIndexPath *toPath = [NSIndexPath indexPathForRow:0 inSection:index.row];
            [self.tabbleView scrollToRowAtIndexPath:toPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } else {
            [BFUtils showAlertController:0 title:@"" message:@"该分类暂无菜品"];
            // 处理分类不会隐藏
            if (![self.presentedViewController isBeingDismissed]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }

    }
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return  UIModalPresentationNone;
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
