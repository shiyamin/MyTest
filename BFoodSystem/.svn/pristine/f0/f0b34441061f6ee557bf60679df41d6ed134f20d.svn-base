//
//  BFFoodDetailTopCell.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodDetailTopCell.h"
#import "BFAreaCollectionViewCell.h"
#import "BFFoodClassModel.h"

@interface BFFoodDetailTopCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation BFFoodDetailTopCell


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 135, SCREEN_WIDTH - 24, 120) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

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

    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    self.backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.backView.layer.borderWidth = 1;
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.priceBackView.layer.cornerRadius = 5;
    self.priceBackView.clipsToBounds = YES;
    self.priceBackView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.priceBackView.layer.borderWidth = 1;
    self.priceBackView.backgroundColor = [UIColor whiteColor];
    
    self.foodNameTf.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    self.foodNameTf.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    
    self.promptLable.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    self.promptLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.cornerRadius = 5;
    self.collectionView.clipsToBounds = YES;
    self.collectionView.layer.borderWidth = 1;
    self.collectionView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.collectionView setCollectionViewLayout:self.layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BFAreaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:BFAreaCollectionViewCellIdentifier];

}

- (void)configFoodName:(NSString *)foodName andFoodPrice:(NSString *)foodPricce{
    self.foodNameTf.text = foodName;
    self.priceTf.text = [NSString stringWithFormat:@"%@",foodPricce];
}

- (void)updataCollectionViewWithFoodClassArr:(NSMutableArray *)foodClassArr{
    self.dataArr = foodClassArr;
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BFAreaCollectionViewCellIdentifier forIndexPath:indexPath];
    BFFoodClassModel *classMdoel = self.dataArr[indexPath.row];
    [cell setAreaName:classMdoel.name];
    [cell setSelectStatus:classMdoel.isSelect];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaCollectionViewCell *cell = (BFAreaCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BFFoodClassModel *model = self.dataArr[indexPath.row];
    model.isSelect = !model.isSelect;
    [cell setSelectStatus:model.isSelect];
    
    if ([self.delegate respondsToSelector:@selector(topCellDidSelectFoodClass:)]) {
        [self.delegate  topCellDidSelectFoodClass:self.dataArr];
    }
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
