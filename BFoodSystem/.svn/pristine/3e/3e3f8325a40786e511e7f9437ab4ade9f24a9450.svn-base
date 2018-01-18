//
//  BFWaiterAreaCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFWaiterAreaCell.h"
#import "BFAreaCollectionViewCell.h"
#import "BFAreaModel.h"

@interface BFWaiterAreaCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation BFWaiterAreaCell

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(SCREEN_WIDTH/3 -20, 30);
    }
    return _layout;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setStatusForSubViews];
    
}


- (void)setStatusForSubViews{
    
    self.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.cornerRadius = 5;
    self.collectionView.clipsToBounds = YES;
    self.collectionView.layer.borderWidth = 1;
    self.collectionView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.collectionView setCollectionViewLayout:self.layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BFAreaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:BFAreaCollectionViewCellIdentifier];
}

- (void)getAreaInfoList:(NSMutableArray *)areaArr{
    self.dataArr = [NSMutableArray arrayWithArray:areaArr];

    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BFAreaCollectionViewCellIdentifier forIndexPath:indexPath];
    BFAreaModel *model = self.dataArr[indexPath.row];
    [cell setAreaName:model.name];
    [cell setSelectStatus:model.isSelect];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaCollectionViewCell *cell = (BFAreaCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BFAreaModel *model = self.dataArr[indexPath.row];
    model.isSelect = !model.isSelect;
    [cell setSelectStatus:model.isSelect];
    [self calculationAreaIds];
}

- (void)calculationAreaIds{
    NSMutableString *areaIds = [NSMutableString string];
    for (int count = 0; count < self.dataArr.count ; count ++ ) {
        BFAreaModel *model = self.dataArr[count];
        if (model.isSelect) {
            if(count == self.dataArr.count -1){
                [areaIds appendString:[NSString stringWithFormat:@"%@",model.areaId]];
            }else{
                [areaIds appendString:[NSString stringWithFormat:@"%@,",model.areaId]];
            }
        }
    }
    if (self.delegate || [self.delegate respondsToSelector:@selector(getAreaIdsFromWaiterAreaCell:)]) {
        [self.delegate getAreaIdsFromWaiterAreaCell:areaIds];
    }
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
