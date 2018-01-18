
//
//  BFWaiterHomeListView.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterHomeListView.h"
#import "BFWaiteHomeListCell.h"
#import "LXBDiningTableViewController.h"
#import "BFAreaModel.h"
#import "BFWaiterList.h"
#import "BFDeskModel.h"
#import "BFDeskAreaServices.h"
//#import "BJNoDataView.h"
#import "UIImageView+ZJFCustomImageView.h"

static NSString *homeListCellID = @"waiteHomeListCellID";

@interface BFWaiterHomeListView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic, strong)UICollectionView *myCollectionView;
@property (nonatomic, strong) UIImageView *showImageView;

@end
@implementation BFWaiterHomeListView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH - 30, self.bounds.size.height)];
    path.lineWidth = 1.0;
    UIColor *color = [UIColor colorWithHex:BF_COLOR_L19];
    [color set];
    [path stroke];
    
    
    
}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //配置子视图
        [self configListSbView];
    
        //加载数据
        [self loadData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:updateWaiterDeskNotification object:nil];
//         [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
#pragma mark - 网络请求
- (void)loadData {
    
    [[BFDeskAreaServices alloc] getDeskAreaWtihSaleStatus:@"" SuccessBlock:^(id result) {
        
        self.dataArr = (NSMutableArray *)result;
        if ([_dataArr isKindOfClass:[NSMutableArray class]]
            && _dataArr.count == 0) {
            _showImageView = [UIImageView showNonDateImageWithAddView:self];
            [_showImageView removeFromSuperview];
            [self addSubview:_showImageView];
        } else if (_dataArr.count > 0) {
            [_showImageView removeFromSuperview];
            
        }
        [self.myCollectionView  reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
//        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
//        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
    
    
}
- (void)configListSbView
{
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    //标题
    UILabel *tilte = [[UILabel alloc] init];
    tilte.text = @"按区分进入餐台列表";
    tilte.font = [UIFont systemFontOfSize:14];
    tilte.textAlignment = NSTextAlignmentCenter;
    tilte.textColor = [UIColor colorWithHex:@"#808080"];
    [self addSubview:tilte];
    [tilte setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [tilte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).with.offset(20);
    }];
    //区的划分
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.minimumLineSpacing = 10;
    layOut.minimumInteritemSpacing = 10;
    layOut.itemSize = CGSizeMake(80, 50);
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_myCollectionView];
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.top.mas_equalTo(tilte.mas_top).with.offset(30);
        make.height.mas_equalTo(110);
        
    }];
    
    //注册
    [_myCollectionView registerClass:[BFWaiteHomeListCell class] forCellWithReuseIdentifier:homeListCellID];
    
    
    
}

#pragma mark  - dataSoure

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BFWaiteHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeListCellID forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.waiterVC.view endEditing:YES];
    
    LXBDiningTableViewController *dingVC = [[LXBDiningTableViewController alloc] init];
    BFAreaModel *model = self.dataArr[indexPath.row];
    //将区域的名字传替
    dingVC.name = model.name;
    dingVC.deskArr = model.desk_list;
    UINavigationController *navg = (UINavigationController *)KEY_WINDOW.rootViewController;
    [navg pushViewController:dingVC animated:YES];
}

#pragma mark-----KVO回调----
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (![keyPath isEqualToString:@"dataArr"]) {
//        return;
//    }
//    if ([self.dataArr count]==0) {//无数据
//        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.myCollectionView icon:nil iconClicked:^{
//            //图片点击回调
//            [self loadData];//刷新数据
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

@end
