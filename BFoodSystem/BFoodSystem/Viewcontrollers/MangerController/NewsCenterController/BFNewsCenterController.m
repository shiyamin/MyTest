//
//  BFNewsCenterController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFNewsCenterController.h"
#import "BFMessageCell.h"
#import "ZJFShowMessageCell.h"
#import "BFShopServices.h"
#import "BFMessageListModel.h"
#import "BJNoDataView.h"
#import "ZJFMessageDetailViewController.h"


@interface BFNewsCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) BFMessageCell *messageCell;

@property (nonatomic, strong) NSMutableArray *dataArr;



@end

@implementation BFNewsCenterController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        
        
        [_tableView registerClass:[BFMessageCell class] forCellReuseIdentifier:@"BFMessageCell"];
        [_tableView registerClass:[ZJFShowMessageCell class] forCellReuseIdentifier:@"ZJFShowMessageCell"];
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    [self setStatusForSubviews];
    [self getMessageInfoRequest];
}

- (void)setStatusForSubviews {
    
    [self.view addSubview:self.tableView];
}

- (void)getMessageInfoRequest {
    NSString *type = @"0";
    
    [[BFShopServices alloc] getMessageListInfoWithMessageType:type SuccessBlock:^(id result) {
        //        BFLog(@"===消息中心===%@", result);
        self.dataArr = [(NSMutableArray *)result lastObject];
        //        if ([_dataArr isKindOfClass:[NSMutableArray class]]
        //            && _dataArr.count == 0) {
        //            _showImageView = [UIImageView showNonDateImageWithAddView:self.tableView];
        //            [_showImageView removeFromSuperview];
        //            [self.tableView addSubview:_showImageView];
        //        } else if (_dataArr.count > 0) {
        //            [_showImageView removeFromSuperview];
        //
        //        }
        [self.tableView  reloadData];    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        } Failure:^(NSError *error) {
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFMessageListModel *model = self.dataArr[indexPath.row];
    if (!model.picurl || !model.picurl.count) {
        ZJFShowMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJFShowMessageCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWtihTime:model.creatTime messageStr:model.content titleStr:model.title];
        return cell;
        
    } else {
        BFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BFMessageCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configCellWtihTime:model.creatTime messageStr:model.content titleStr:model.title picStr:model.picurl];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJFMessageDetailViewController *detailVc = [[ZJFMessageDetailViewController alloc] init];
    detailVc.listModel = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tableView icon:nil iconClicked:^{
            //图片点击回调
            [self getMessageInfoRequest];//刷新数据
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
