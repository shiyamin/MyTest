//
//  BFDeskMangerController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskMangerController.h"
#import "BFDeskMangerCell.h"
#import "BFNewDeskController.h"
#import "BFShopServices.h"
#import "BFAreaModel.h"
#import "BFDeskModel.h"
#import "BJNoDataView.h"

@interface BFDeskMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic, strong)NSMutableArray *openArr;

@end



@implementation BFDeskMangerController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        _tabbleView.tableFooterView = footView;
    }
    return _tabbleView;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)openArr {
    if (!_openArr) {
        _openArr = [NSMutableArray array];
    }
    return _openArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"餐台管理";
    [self setStatusForSubViews];
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    [self getAreaListInfo];
}

- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFDeskMangerCell" bundle:nil] forCellReuseIdentifier:BFDeskMangerCellIdentifier];
    
    
    UIButton *newDeskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newDeskBtn setFrame:CGRectMake(0,SCREEN_HEIGHT - 110, SCREEN_WIDTH, 46)];
    [self.view addSubview:newDeskBtn];
    [newDeskBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    [newDeskBtn setTitle:@"新增餐台" forState:UIControlStateNormal];
    [newDeskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newDeskBtn addTarget:self action:@selector(newBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getAreaListInfo{
    [[BFShopServices alloc] getDeskAreaInfoWithSuccessBlock:^(id result) {
        self.dataArr = (NSMutableArray *)result;
        if (self.openArr.count == 0) {
            for (int index = 0; index < self.dataArr.count; index ++) {
                NSString *isOpen = @"no";
                [self.openArr addObject:isOpen];
            }
        }
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
    BFAreaModel *areaModel = self.dataArr[section];
    NSString *isopen = self.openArr[section];
    if ([isopen isEqualToString:@"yes"]) {
        return areaModel.desk_list.count;
    }
    return 0;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFDeskMangerCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BFAreaModel *areaModel = self.dataArr[section];
    UIView *sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B11];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 5, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [sectionView addSubview:lineView];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 1, SCREEN_WIDTH-5, 39)];
    titleLab.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    titleLab.text = [NSString stringWithFormat:@"    %@",areaModel.name];
    titleLab.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    [sectionView addSubview:titleLab];
    UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchBtn setFrame:titleLab.frame];
    [sectionView addSubview:touchBtn];
    touchBtn.tag = section;
    [touchBtn addTarget:self action:@selector(headViewTochAction:) forControlEvents:UIControlEventTouchUpInside];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFDeskMangerCell *cell = [tableView dequeueReusableCellWithIdentifier:BFDeskMangerCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFAreaModel *areaModel = self.dataArr[indexPath.section];
    BFDeskModel *deskModel = areaModel.desk_list[indexPath.row];
    [cell configDeskMangerCellWithDeskName:deskModel.name PersonNum:deskModel.num deskType:deskModel.type waiterName:areaModel.waiter_list];
    return cell;
}

/**~~~~特效~~~~**/
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat offSet = tableView.contentOffset.y;
//    if (offSet<=0) {
//        return;
//    }
//    CGRect oldRect = cell.frame;
//    CGRect newRect = cell.frame;
//    newRect.origin.y += 50;
//    cell.frame = newRect;
//    [UIView animateWithDuration:0.5 animations:^{
//         cell.frame = oldRect;
//    }];
//}


//#pragma mark 选择编辑模式，添加模式很少用,默认是删除
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleNone;
//}
//
//#pragma mark 排序 当移动了某一行时候会调用
////编辑状态下，只要实现这个方法，就能实现拖动排序
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaModel *areaModel = self.dataArr[indexPath.section];
    BFDeskModel *deskModel = areaModel.desk_list[indexPath.row];
    BFNewDeskController *newDeskVc = [[BFNewDeskController alloc] init];
    newDeskVc.deskType = newDeskTypeDetail;
    newDeskVc.deskMangerVc = self;
    [self.navigationController pushViewController:newDeskVc animated:YES];
    [newDeskVc getAreaArrList:self.dataArr areaId:areaModel.areaId];
    [newDeskVc getDeskDetail:deskModel areaName:areaModel.name];
}

- (void)newBtnClick:(UIButton *)sender{
    BFNewDeskController *newDeskVc = [[BFNewDeskController alloc] init];
    newDeskVc.deskType = newDeskTypeAdd;
    [newDeskVc getAreaArrList:self.dataArr areaId:@""];
    newDeskVc.deskMangerVc = self;
    [self.navigationController pushViewController:newDeskVc animated:YES];
}


- (void)headViewTochAction:(UIButton *)btn{
    for (NSInteger count = 0; count < self.dataArr.count; count ++) {
        if (btn.tag == count) {
            NSString *str = self.openArr[count];
            if ([str isEqualToString:@"yes"]) {
                str = @"no";
            }else{
                str = @"yes";
            }
            [self.openArr replaceObjectAtIndex:count withObject:str];
        }
    }
    NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:btn.tag];
    [self.tabbleView reloadSections:indexset withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tabbleView icon:nil iconClicked:^{
            //图片点击回调
            [self getAreaListInfo];//刷新数据
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




@end
