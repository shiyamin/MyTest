//
//  BFClinetsManagerControllerViewController.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFClientsManagerController.h"
#import "UIButton+BFRedButton.h"
#import "BFShopServices.h"
#import "BFMassMessageController.h"
#import "BFMessageCell.h"
#import "ZJFShowMessageCell.h"
#import "BFMessageListModel.h"
#import "BFMessageModel.h"
#import "ZJFMessageDetailViewController.h"
#import "BFClientMessageDetailController.h"
//#import "BJNoDataView.h"
#import "UIImageView+ZJFCustomImageView.h"

@interface BFClientsManagerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)BFMessageCell *messageCell;

@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)UILabel *clientNumberLabel;

@property (nonatomic, strong) UIImageView *showImageView;


@end

@implementation BFClientsManagerController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH_SCREEN, HEIGHT_SCREEN - self.navigationController.navigationBar.frame.size.height-100)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.scrollEnabled = YES;
        
        [_tableView registerClass:[BFMessageCell class] forCellReuseIdentifier:@"BFMessageCell"];
        [_tableView registerClass:[ZJFShowMessageCell class] forCellReuseIdentifier:@"ZJFShowMessageCell"];
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户管理";
    [self getMessageInfoRequest];
    [self setStatusForSubViews];
    //    [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

- (void)getMessageInfoRequest {
    NSString *type = @"1";
    [[BFShopServices alloc] getMessageListInfoWithMessageType:type SuccessBlock:^(id result) {
        BFLog(@"===消息中心===%@", result);
        NSMutableArray *arr = (NSMutableArray *)result;
        BFMessageModel *model = [arr firstObject];
        _dataArr = [arr lastObject];
        _clientNumberLabel.text = [NSString stringWithFormat:@"当前顾客数:%@人",model.customer];
        if ([_dataArr isKindOfClass:[NSMutableArray class]]
            && _dataArr.count == 0) {
            _showImageView = [UIImageView showNonDateImageWithAddView:self.tableView];
            [_showImageView removeFromSuperview];
            [self.tableView addSubview:_showImageView];
        } else if (_dataArr.count > 0) {
            [_showImageView removeFromSuperview];
            
        }
        [self.tableView  reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

- (void)setStatusForSubViews {
    
    _clientNumberLabel = [[UILabel alloc] init];
    [self.view addSubview:_clientNumberLabel];
    _clientNumberLabel.textColor = [UIColor colorWithHex:BF_COLOR_B4];
    _clientNumberLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    _clientNumberLabel.backgroundColor = [UIColor whiteColor];
    _clientNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_clientNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sendMessageButton];
    [sendMessageButton setButtonRedStatus];
    sendMessageButton.layer.cornerRadius = 0;
    [sendMessageButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendMessageButton setTitle:@"新建群发消息" forState:UIControlStateNormal];
    [sendMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(WIDTH_SCREEN);
    }];
    
    [self.view addSubview:self.tableView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFMessageListModel *model = self.dataArr[indexPath.row];
    NSString *contentStr;
    
    NSInteger charLength = 25;
    if (!model.picurl || !model.picurl.count) {
        ZJFShowMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZJFShowMessageCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        contentStr = model.content;
        if (model.content.length >charLength) {
            contentStr = [model.content substringToIndex:charLength];
        }
        [cell configCellWtihTime:model.creatTime messageStr:contentStr titleStr:model.title];
        return cell;
        
    } else {
        BFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BFMessageCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        contentStr = model.content;
        if (model.content.length >charLength) {
            contentStr = [model.content substringToIndex:charLength];
        }
        [cell configCellWtihTime:model.creatTime messageStr:contentStr titleStr:model.title picStr:model.picurl];
        return cell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFClientMessageDetailController *detailVc = [[BFClientMessageDetailController alloc] init];
    detailVc.listModel = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

- (void)btnAction:(UIButton *)sender {
    
    BFMassMessageController *massVc = [[BFMassMessageController alloc] init];
    massVc.clientVc = self;
    [self.navigationController pushViewController:massVc animated:YES];
    
}
//#pragma mark-----KVO回调----
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (![keyPath isEqualToString:@"dataArr"]) {
//        return;
//    }
//    if ([self.dataArr count]==0) {//无数据
//        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tableView icon:nil iconClicked:^{
//            //图片点击回调
//            [self getMessageInfoRequest];//刷新数据
//        }];
//        return;
//    }
//    //有数据
//    [[BJNoDataView shareNoDataView] clear];
//}
//-(void)dealloc{
//    //移除KVO
//    [self removeObserver:self forKeyPath:@"dataArr"];
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
