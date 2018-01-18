//
//  BFFoodMangerController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodMangerController.h"
#import "BFFoodTableCell.h"
#import "BFFoodSectionView.h"
#import "BFFoodClassPopController.h"
#import "BFFoodController.h"
#import "BFAddFoodClassController.h"
#import "BFAddFoodDetailController.h"
#import "BFFoodServices.h"
#import "BFFoodClassModel.h"
#import "BFFoodModel.h"

@interface BFFoodMangerController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,BFFoodClassPopControllerDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation BFFoodMangerController

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
    self.title = @"菜品管理";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFoodList) name:updateFoodListNotification object:nil];
    
    [self setStatusForSubViews];
    [self getFoodList];
}

- (void)setStatusForSubViews{
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
    
    [classBtn setImage:[UIImage imageNamed:@"cd_fenlei"] forState:UIControlStateNormal];
    [foodBtn setImage:[UIImage imageNamed:@"cd_caipin"] forState:UIControlStateNormal];

}


- (void)getFoodList{
    
    [[BFFoodServices alloc] getDishesListWtihSaleStatus:@"1" SuccessBlock:^(id result) {
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
#pragma mark - scrollview delegate and datasource
//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 33;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFFoodTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BFFoodTableCellIdentifier forIndexPath:indexPath];
    BFFoodClassModel *classModel = self.dataArr[indexPath.section];
    [cell hiddenSalesButton];
    BFFoodModel *foodModel = classModel.dishesArr[indexPath.row];
    [cell configFoodImage:foodModel.pic_url.firstObject foodName:foodModel.name foodPrice:foodModel.price];
    [cell hiddenMiddleButton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAddFoodDetailController *addVc = [[BFAddFoodDetailController alloc] init];
    BFFoodClassModel *classModel = self.dataArr[indexPath.section];
    BFFoodModel *foodModel = classModel.dishesArr[indexPath.row];
    addVc.foodModel = foodModel;
    addVc.foodVcType = foodDetailChange;
    [self.navigationController pushViewController:addVc animated:YES];
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
        [foodClassVc updateAreaWithDataArr:self.dataArr];
        [self presentViewController:foodClassVc animated:YES completion:nil];
    }else if (sender.tag == 2){
        BFFoodController *foodVc = [[BFFoodController alloc] init];
        [self.navigationController pushViewController:foodVc animated:YES];
    }
}

- (void)didSelectRowAtIndex:(NSIndexPath *)index andSelectType:(NSString *)type{
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

//        if (classModel.dishesArr.count == 0) {
//            return ;
//        }
//        NSIndexPath *toPath = [NSIndexPath indexPathForRow:0 inSection:index.row];
//        [self.tabbleView scrollToRowAtIndexPath:toPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return  UIModalPresentationNone;
}

- (void)dealloc{
    
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
