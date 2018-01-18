//
//  LXBDiningTableViewController.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBDiningTableViewController.h"
#import "LXBCollectionView.h"
#import "Masonry.h"
#import "LXBHeaderView.h"
//#import "BJNoDataView.h"
#import "UIImageView+ZJFCustomImageView.h"
@interface LXBDiningTableViewController ()
@property (nonatomic, strong) UIImageView *showImageView;
@end

@implementation LXBDiningTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithHex:BF_COLOR_L25];
    //消除返回按钮
//    [self addObserver:self forKeyPath:@"deskArr" options:NSKeyValueObservingOptionNew context:nil];
	self.navigationItem.leftBarButtonItem = [self backItemWithimage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"]  target:self action:@selector(popVC) title:@""];
	self.view.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
	self.title = @"餐台列表";

	LXBHeaderView * headerView = [[LXBHeaderView alloc]initWithFrame:CGRectZero];
	headerView.titleString = @"请选择您要操作的餐台";
	headerView.tag = 99;
	[self.view addSubview:headerView];
	[headerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.view.mas_left).with.offset(0);
		make.right.equalTo(self.view.mas_right).with.offset(0);
		make.top.equalTo(self.view.mas_top).with.offset(0);
		make.height.with.offset(40);
	}];
	
	LXBCollectionView * collectionView = [[LXBCollectionView alloc]init];
	[self.view addSubview:collectionView];
	collectionView.tag = 100;
	
	[collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.view.mas_left).with.offset(0);
		make.right.equalTo(self.view.mas_right).with.offset(0);
		make.top.equalTo(headerView.mas_bottom).with.offset(20);
		make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
	}];
	
}
//返回
- (void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setDeskArr:(NSArray *)deskArr
{
	_deskArr = deskArr;
	LXBCollectionView * colView = (LXBCollectionView *)[self.view viewWithTag:100];
	//将区域的名字保留
	colView.eareName = self.name;
	colView.dataArr = _deskArr;
//   
    if ([_deskArr isKindOfClass:[NSMutableArray class]]
        && _deskArr.count == 0) {
        _showImageView = [UIImageView showNonDateImageWithAddView:colView];
        [_showImageView removeFromSuperview];
        [colView.collectionView addSubview:_showImageView];
    } else if (_deskArr.count > 0) {
        [_showImageView removeFromSuperview];

    }
    	[colView.collectionView reloadData];
    
}


- (void)hiddenTopTitleLable{
	LXBHeaderView *headView = (LXBHeaderView *)[self.view viewWithTag:99];
	LXBCollectionView * colView = (LXBCollectionView *)[self.view viewWithTag:100];
	headView.hidden = YES;
	[colView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view.mas_top).with.offset(10);
		make.left.equalTo(self.view.mas_left).with.offset(0);
		make.right.equalTo(self.view.mas_right).with.offset(0);
		make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
	}];
}

#pragma mark-----KVO回调----
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (![keyPath isEqualToString:@"deskArr"]) {
//        return;
//    }
//    LXBCollectionView * colView = (LXBCollectionView *)[self.view viewWithTag:100];
//    if ([self.deskArr count]==0) {//无数据
//        [[BJNoDataView shareNoDataView] showCenterWithSuperView:colView.collectionView icon:nil iconClicked:^{
//            //图片点击回调
//            [colView.collectionView reloadData];//刷新数据
//        }];
//        return;
//    }
//    //有数据
//    [[BJNoDataView shareNoDataView] clear];
//}
//-(void)dealloc{
//    //移除KVO
//    [self removeObserver:self forKeyPath:@"deskArr"];
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
