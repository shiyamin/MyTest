//
//  BFHomeTopView.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/14.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFHomeTopView.h"
#import "BFScrollMiddleView.h"
#import "BFScrollFirView.h"

@interface BFHomeTopView ()<UIScrollViewDelegate>

@property (nonatomic, strong) BFScrollFirView *firView;

@property (nonatomic, strong)BFScrollMiddleView *middleView;

@property (strong, nonatomic) UIScrollView *scrollPageView;

@property (strong, nonatomic) UIPageControl *pageContro;

@property (strong, nonatomic) UIButton *refreshBtn;


@end

@implementation BFHomeTopView



-(UIScrollView *)scrollPageView{
    if (!_scrollPageView) {
        _scrollPageView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH - 30, 160)];
        _scrollPageView.showsVerticalScrollIndicator = NO;
        _scrollPageView.showsHorizontalScrollIndicator = NO;
        _scrollPageView.delegate = self;
    }
    return _scrollPageView;
}


- (UIPageControl *)pageContro{
    if (!_pageContro) {
        _pageContro = [[UIPageControl alloc] init];
        _pageContro.numberOfPages = 2;
    }
    return _pageContro;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self configSubviews];
    
}


- (void)configSubviews{
    
    
    self.backgroundColor = [UIColor colorWithHex:@"#f5f5f5"];
    
    self.firView = [[BFScrollFirView alloc] init];
    [self.firView setFrame:CGRectMake(0, 0, self.scrollPageView.frame.size.width, self.scrollPageView.frame.size.height)];
    [self.scrollPageView addSubview:self.firView];
    
    self.middleView = [[[NSBundle mainBundle] loadNibNamed:@"BFScrollMiddleView" owner:nil options:nil] lastObject];
    [self addSubview:self.scrollPageView];
    [self.middleView setFrame:CGRectMake(self.scrollPageView.frame.size.width, 0, self.scrollPageView.frame.size.width, self.scrollPageView.frame.size.height)];
    self.scrollPageView.contentSize = CGSizeMake(self.scrollPageView.frame.size.width * 2, self.scrollPageView.frame.size.height);
    [self.scrollPageView setContentOffset:CGPointMake(self.scrollPageView.frame.size.width *1, 0)];

    self.scrollPageView.pagingEnabled = YES;
    self.scrollPageView.layer.cornerRadius = 5;
    self.scrollPageView.clipsToBounds = YES;
    self.scrollPageView.layer.borderWidth = 1.0;
    self.scrollPageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.pageContro setFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 20)];
    self.pageContro.currentPage = 1;
    self.pageContro.pageIndicatorTintColor = [UIColor colorWithHex:@"#cacaca"];
    self.pageContro.currentPageIndicatorTintColor = [UIColor colorWithHex:@"e55c25"];
    [self addSubview:self.pageContro];
    [self.scrollPageView addSubview:self.middleView];
    
    self.refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshBtn setImage:[UIImage imageNamed:@"shauxin"] forState:UIControlStateNormal];
    [self.refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.refreshBtn addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.refreshBtn];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollPageView).offset(2);
        make.right.equalTo(self.scrollPageView).offset(-5);
        make.width.height.mas_equalTo(50);
    }];
    
    
}


- (void)refreshAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(refreshHeadViewData)]) {
        [self.delegate refreshHeadViewData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageContro.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);

}



- (void)configTopInfoWith:(BFQueryDailyModel *)model{
    
    if (model) {
        [self.firView setFirViewInfoWith:model];
        [self.middleView configInfoWithSaleNum:model.total personNum:model.diner orderNum:model.orders rightNum:model.perDiner];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}



@end
