//
//  BFShopHeadView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/16.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopHeadView.h"
#import "BFShopHeadPicCell.h"
#import "BFShopPicModel.h"


#define collectionViewHeight  SCREEN_WIDTH-20

@interface BFShopHeadView () <UICollectionViewDelegate,UICollectionViewDataSource>{
    NSTimer *_timer;
}

@property (nonatomic, strong)UIButton *shopIcon;



@property(strong,nonatomic) UICollectionViewFlowLayout *layout;
@property(strong,nonatomic) UIPageControl *pageControl;

@property(nonatomic, assign) picType picType;



@end



@implementation BFShopHeadView

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(collectionViewHeight, 150);
        _layout.minimumLineSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (UICollectionView *)picCollectionView{
    if (!_picCollectionView) {
        _picCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, collectionViewHeight, 150) collectionViewLayout:self.layout];
        _picCollectionView.delegate = self;
        _picCollectionView.dataSource = self;
        _picCollectionView.pagingEnabled = YES;
        _picCollectionView.showsVerticalScrollIndicator = NO;
        _picCollectionView.showsHorizontalScrollIndicator = NO;
        [_picCollectionView registerNib:[UINib nibWithNibName:@"BFShopHeadPicCell" bundle:nil] forCellWithReuseIdentifier:BFShopHeadPicCellIdentifier];
    }
    return _picCollectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHex:@"#cacaca"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:@"e55c25"];
    }
    return _pageControl;
}


- (instancetype)init{
    if (self = [super init]) {
        [self addSubviewsAndSetStatus];
        [self addDefaultData];
    }
    return self;
}


- (void)addSubviewsAndSetStatus{
    
    self.shopIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.shopIcon];
    [self.shopIcon addTarget:self action:@selector(iconAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.height.mas_equalTo(40);
    }];
    
    self.shopTitleTF = [[UITextField alloc] init];
    self.shopTitleTF.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.shopTitleTF.textAlignment = NSTextAlignmentCenter;
    self.shopTitleTF.placeholder = @"请输入商铺名称";
    [self addSubview:self.shopTitleTF];
    [self.shopTitleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.shopIcon.mas_bottom).offset(2);
        make.height.mas_equalTo(20);
    }];
    
    
    
    [self addSubview:self.picCollectionView];
    
    
}


- (void)addPageControllFroCollection{
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.picCollectionView);
        make.height.mas_equalTo(20);
    }];
    self.pageControl.numberOfPages = self.dataArray.count;


}

- (void)addDefaultData{
    self.picType = picDefaultType;
    BFShopPicModel *model = [[BFShopPicModel alloc] init];
    model.url = @"dm_banner";
    [self.dataArray addObject:model];
}


- (void)configIcon:(NSString *)iconName shopTitle:(NSString *)title{

    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:iconName] forState:UIControlStateNormal];
    if (!iconName || [iconName isEqualToString:@""]) {
        [self.shopIcon setImage:[UIImage imageNamed:@"bf_icon"] forState:UIControlStateNormal];
    }
    self.shopTitleTF.text = title;
}

- (void)configImage:(UIImage *)image{
    [self.shopIcon setImage:image forState:UIControlStateNormal];

}

- (void)configShopPicList:(NSArray *)picArr{
    if (picArr.count ==0) {
        return;
    }
    [self.dataArray removeAllObjects];
    
    dispatch_group_t group = dispatch_group_create();

        for (NSString *urlStr in picArr) {
            dispatch_group_enter(group);
            SDWebImageManager *manager = [SDWebImageManager sharedManager] ;
            [manager downloadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:^(NSInteger   receivedSize, NSInteger expectedSize) {
                
            }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,   BOOL finished, NSURL *imageURL) {
                if (image) {
                    [self.dataArray addObject:image];
                }
                dispatch_group_leave(group);
            }];
        }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.picType = picUrlType;
        [self addPageControllFroCollection];
        [self.picCollectionView reloadData];
        if (picArr.count >1) {
            [self timerInvalidate];
          _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runalway) userInfo:nil repeats:YES];
        }
    });

}


-(void)timerInvalidate{
    [_timer invalidate];
    _timer = nil;
}

- (void)configShopPicListWithImageArr:(NSArray *)imageArr{
    if(imageArr.count == 0){
        return;
    }
    [self.dataArray removeAllObjects];
    self.dataArray = [imageArr mutableCopy];
    self.picType = picImageType;
    [self addPageControllFroCollection];
    [self.picCollectionView reloadData];
    if (imageArr.count >1) {
        [self timerInvalidate];
       _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runalway) userInfo:nil repeats:YES];
    }

}


- (void)runalway{
    NSInteger num = (self.picCollectionView.contentOffset.x + self.picCollectionView.frame.size.width) / self.picCollectionView.frame.size.width;
//    BFLog(@"num ========   %ld", (long)num);
    [self.picCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:num  inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger num = (self.picCollectionView.contentOffset.x ) / self.picCollectionView.frame.size.width;
    self.pageControl.currentPage = num % self.dataArray.count;
//    BFLog(@"pageControl Num ========   %ld", (long)num);

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count * 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BFShopHeadPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BFShopHeadPicCellIdentifier forIndexPath:indexPath];
    if (self.picType == picDefaultType) {
        BFShopPicModel *model = self.dataArray[indexPath.item % self.dataArray.count];
        if (model.url) {
            cell.headImageView.image = [BFUtils cutImage:[UIImage imageNamed:model.url] forImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        }
        
    }else if(self.picType == picImageType){
        UIImage *picImage = (UIImage *)self.dataArray[indexPath.item % self.dataArray.count];
        cell.headImageView.image = [BFUtils cutImage:picImage forImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    }else if(self.picType == picUrlType){
//        BFShopPicModel *model = self.dataArray[indexPath.item % self.dataArray.count];
//        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
        UIImage *picImage = (UIImage *)self.dataArray[indexPath.item % self.dataArray.count];
        cell.headImageView.image = [BFUtils cutImage:picImage forImageViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headViewPicItemAction:)]) {
        [self.delegate headViewPicItemAction:indexPath];
    }
}

- (void)iconAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headIconAction)]) {
        [self.delegate headIconAction];
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
