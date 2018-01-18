//
//  BFDeskAreaController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/20.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskAreaController.h"
#import "BFDeskMangerController.h"
#import "BFAreaMangerController.h"
#import "BFDeskSelectView.h"


@interface BFDeskAreaController ()<BFDeskSelectViewDelegate>

@end

@implementation BFDeskAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"餐台/区域管理";
    [self addSubviews];
}


- (void)addSubviews{
    UILabel *topLabe = [[UILabel alloc] init];
    topLabe.text = @"(首次打开请先添加区域)";
    topLabe.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    topLabe.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    topLabe.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topLabe];
    [topLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    
    BFDeskSelectView *areaSelectView = [[BFDeskSelectView alloc] init];
    areaSelectView.layer.cornerRadius = 5;
    areaSelectView.clipsToBounds = YES;
    areaSelectView.delegate = self;
    areaSelectView.viewIdentifier = @"areaView";
    [areaSelectView configBackGroundImage:@"qy_cantai" titleImage:@"qy_cantai_wenzi"];

    [self.view addSubview:areaSelectView];
    [areaSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(topLabe.mas_bottom).offset(5);
        make.height.mas_equalTo(120);
    }];
    
    
    BFDeskSelectView *deskSelectView = [[BFDeskSelectView alloc] init];
    deskSelectView.layer.cornerRadius = 5;
    deskSelectView.clipsToBounds = YES;
    deskSelectView.delegate = self;
    deskSelectView.viewIdentifier = @"deskView";
    [deskSelectView configBackGroundImage:@"qy_quyu" titleImage:@"qy_quyu_wenzi"];
    [self.view addSubview:deskSelectView];
    [deskSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(areaSelectView.mas_bottom).offset(5);
        make.height.mas_equalTo(120);
    }];

    
}


- (void)viewDidSelected:(NSString *)viewIdentifier{
    if ([viewIdentifier isEqualToString:@"areaView"]) {
        BFAreaMangerController *areaVc = [[BFAreaMangerController alloc] init];
        [self.navigationController pushViewController:areaVc animated:YES];
    }else if ([viewIdentifier isEqualToString:@"deskView"]){
        BFDeskMangerController *deskVc = [[BFDeskMangerController alloc] init];
        [self.navigationController pushViewController:deskVc animated:YES];
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
