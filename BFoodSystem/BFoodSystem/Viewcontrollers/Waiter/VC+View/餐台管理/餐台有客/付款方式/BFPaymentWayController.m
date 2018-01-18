//
//  BFPaymentWayController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/13.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFPaymentWayController.h"
#import "BFPaymentWayCollCell.h"
#import "BFOrderServices.h"

@interface BFPaymentWayController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic, strong)UICollectionView *myCollectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *layout;
@property(nonatomic, strong)NSMutableArray *dataArr;


@end

@implementation BFPaymentWayController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}


- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {

        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT - 64) collectionViewLayout:self.layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    }
    return _myCollectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
    [self config];
    [self.view addSubview:self.myCollectionView];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"BFPaymentWayCollCell" bundle:nil] forCellWithReuseIdentifier:BFPaymentWayCollCellIdentifier];

}


- (void)config{
    
    NSMutableDictionary *dic1 = [@{@"icon":@"zhifubao",@"title":@"支付宝",@"typeId":@"4"} mutableCopy];
    NSMutableDictionary *dic2 = [@{@"icon":@"weixin",@"title":@"微信",@"typeId":@"3"}mutableCopy];
    NSMutableDictionary *dic3 = [@{@"icon":@"meituan",@"title":@"美团",@"typeId":@"7"}mutableCopy];
    NSMutableDictionary *dic4 = [@{@"icon":@"xianjin",@"title":@"现金",@"typeId":@"2"}mutableCopy];
    NSMutableDictionary *dic5 = [@{@"icon":@"guazhang",@"title":@"挂账",@"typeId":@"8"}mutableCopy];
    NSMutableDictionary *dic6 = [@{@"icon":@"huiyuanka",@"title":@"会员卡支付",@"typeId":@"6"} mutableCopy];
    self.dataArr = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,nil];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100,100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 30, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFPaymentWayCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BFPaymentWayCollCellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.dataArr[indexPath.row];
    [cell configIconWithIconName:[dic objectForKey:@"icon"] titleName:[dic objectForKey:@"title"]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArr[indexPath.row];
    //传桌子的id
    
    
    [[BFOrderServices alloc] orderPaymentWayWithOrderId:self.desk_id payType:[dic objectForKey:@"typeId"] SuccessBlock:^(id result) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"买单成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        [self presentViewController:alertVc animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:updateWaiterDeskNotification object:nil];
        if (self.tapBlock) {
            self.tapBlock();
        }
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
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
