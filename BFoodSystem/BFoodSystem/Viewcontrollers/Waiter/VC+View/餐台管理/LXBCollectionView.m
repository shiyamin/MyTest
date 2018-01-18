//
//  LXBCollectionView.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBCollectionView.h"
#import "LXBDiningTableCollectionViewCell.h"
#import "BFDingNoPeopleController.h"
#import "LXBGuestViewController.h"
@interface LXBCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end
@implementation LXBCollectionView


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[LXBDiningTableCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
       
    }
    return _collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        
        [self addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
//        [self requestData];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LXBDiningTableCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    LXBDiningTableCollectionViewCell * myCell = (LXBDiningTableCollectionViewCell *)cell;
    //此处给cell赋值
    myCell.model = self.dataArr[indexPath.row];

}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPhone6plus) {
        return CGSizeMake(110, 85);
    }else
    if (IS_IPhone6) {
        return CGSizeMake(100, 80);
    }else {
        return CGSizeMake(80, 60);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 20.0f, 20.0f, 20.0f);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BFDeskModel *model = self.dataArr[indexPath.row];
	//点击cell
    //判断是否为空桌和有人
    //空桌
    if ([model.status integerValue] == 1) {
        //表示是空桌
        BFDingNoPeopleController *dingNoP = [[BFDingNoPeopleController alloc] init];
        dingNoP.name = [NSString stringWithFormat:@"餐桌%@(空桌)",model.name];
        dingNoP.deskModel = model;
        UINavigationController *nagVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nagVC pushViewController:dingNoP animated:YES];
    }else {
        

        LXBGuestViewController * guestVC = [[LXBGuestViewController alloc] init];
        //如果是没有区域信息
        if (_eareName == nil) {
            _eareName = @"";
        }
        NSDictionary *dic = @{
                              @"areaName":_eareName,
                              @"deskId": model.deskId
                              };
        guestVC.messageDic = dic;
        guestVC.deskName = [NSString stringWithFormat:@"餐桌%@",model.name];
        guestVC.mealNumber = model.number;
        UINavigationController *nagVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nagVC pushViewController:guestVC animated:YES];

        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
