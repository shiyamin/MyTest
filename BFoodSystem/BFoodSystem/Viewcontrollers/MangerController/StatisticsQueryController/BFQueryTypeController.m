//
//  BFQueryTypeController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryTypeController.h"
#import "BFDeskSelectView.h"
#import "BFQueryYearController.h"
#import "BFQueryFoodController.h"
#import "BFQueryTodayController.h"
#import "BFQueryOffSaleController.h"

@interface BFQueryTypeController ()<BFDeskSelectViewDelegate>

@end

@implementation BFQueryTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计报表";
    [self addSubviews];
}


- (void)addSubviews{

    UIScrollView *scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGFloat scroHeight = SCREEN_HEIGHT;
    if (scroHeight == 480) {
        scroHeight = 667;
    }
    scroView.contentSize = CGSizeMake(SCREEN_WIDTH, scroHeight);
    scroView.showsVerticalScrollIndicator = NO;
    scroView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroView];
    
    BFDeskSelectView *monthsSelectView = [[BFDeskSelectView alloc] init];
    monthsSelectView.layer.cornerRadius = 5;
    monthsSelectView.clipsToBounds = YES;
    monthsSelectView.delegate = self;
    monthsSelectView.viewIdentifier = @"monthsSelectView";
    [monthsSelectView setTitleImageViewFrame];
    [monthsSelectView configBackGroundImage:@"cx_baobiao" titleImage:@"cx_baobiao_wenzi"];
    
    [scroView addSubview:monthsSelectView];
    monthsSelectView.frame = CGRectMake(12, 5, SCREEN_WIDTH - 24, 120);
//    [monthsSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(self.view).offset(5);
//        make.height.mas_equalTo(120);
//    }];
    
    
    BFDeskSelectView *daySelectView = [[BFDeskSelectView alloc] init];
    daySelectView.layer.cornerRadius = 5;
    daySelectView.clipsToBounds = YES;
    daySelectView.delegate = self;
    daySelectView.viewIdentifier = @"daySelectView";
    [daySelectView configBackGroundImage:@"cx_liushui" titleImage:@"cx_liushui_wenzi"];
    [daySelectView setTitleImageViewFrame];
    [scroView addSubview:daySelectView];
    [daySelectView setFrame:CGRectMake(12, monthsSelectView.frame.origin.y + monthsSelectView.frame.size.height + 20, SCREEN_WIDTH-24, 120)];
//    [daySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(monthsSelectView.mas_bottom).offset(5);
//        make.height.mas_equalTo(120);
//    }];
    
    
    BFDeskSelectView *foodSelectView = [[BFDeskSelectView alloc] init];
    foodSelectView.layer.cornerRadius = 5;
    foodSelectView.clipsToBounds = YES;
    foodSelectView.delegate = self;
    foodSelectView.viewIdentifier = @"foodSelectView";
    [foodSelectView setTitleImageViewFrame];
    [foodSelectView configBackGroundImage:@"cx_xiaoliang" titleImage:@"cx_xiaoliang_wenzi"];
    [scroView addSubview:foodSelectView];
    [foodSelectView setFrame:CGRectMake(12, daySelectView.frame.origin.y + daySelectView.frame.size.height + 20, SCREEN_WIDTH-24, 120)];

//    [foodSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(daySelectView.mas_bottom).offset(5);
//        make.height.mas_equalTo(120);
//    }];
    
    BFDeskSelectView *offSaleSelectView = [[BFDeskSelectView alloc] init];
    offSaleSelectView.layer.cornerRadius = 5;
    offSaleSelectView.clipsToBounds = YES;
    offSaleSelectView.delegate = self;
    offSaleSelectView.viewIdentifier = @"offSaleSelectView";
    [offSaleSelectView setTitleImageViewFrame];
    [offSaleSelectView configBackGroundImage:@"cx_caipinchexiao" titleImage:@"cx_caipinchexiao_wenzi"];
    [scroView addSubview:offSaleSelectView];
    [offSaleSelectView setFrame:CGRectMake(12, foodSelectView.frame.origin.y + foodSelectView.frame.size.height +20, SCREEN_WIDTH-24, 120)];

//    [offSaleSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.right.equalTo(self.view).offset(-12);
//        make.top.equalTo(foodSelectView.mas_bottom).offset(5);
//        make.height.mas_equalTo(120);
//    }];
    
}


- (void)viewDidSelected:(NSString *)viewIdentifier{
    
    if ([viewIdentifier isEqualToString:@"monthsSelectView"]) {
        BFQueryYearController *queryYearVc = [[BFQueryYearController alloc] init];
        [self.navigationController pushViewController:queryYearVc animated:YES];
        
    }else if ([viewIdentifier isEqualToString:@"daySelectView"]){
        BFQueryTodayController *queryDayVc = [[BFQueryTodayController alloc] init];
        [self.navigationController pushViewController:queryDayVc animated:YES];
 
    }else if ([viewIdentifier isEqualToString:@"foodSelectView"]){
        
        BFQueryFoodController *queryFoodVc = [[BFQueryFoodController alloc] init];
        [self.navigationController pushViewController:queryFoodVc animated:YES];
    }else if ([viewIdentifier isEqualToString:@"offSaleSelectView"]){
        
        BFQueryOffSaleController *queryOffSaleVc = [[BFQueryOffSaleController alloc] init];
        [self.navigationController pushViewController:queryOffSaleVc animated:YES];

    }
}
- (void)dealloc {
  
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
