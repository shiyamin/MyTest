//
//  BFQueryBaseController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryBaseController.h"

@interface BFQueryBaseController () <BFDataSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>


@end

@implementation BFQueryBaseController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(20, 230, SCREEN_WIDTH -40, SCREEN_HEIGHT - 296) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        _tabbleView.separatorColor = [UIColor clearColor];
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    }
    return _tabbleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusForSubViews];
    [self addSubviews];
    
}

- (void)setStatusForSubViews{
    self.dataView = [[NSBundle mainBundle] loadNibNamed:@"BFDataSearchView" owner:nil options:0].lastObject;
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(200);
    }];
}

- (void)addSubviews{
    
}

- (void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr{
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
//    return nil;
    abort();
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
