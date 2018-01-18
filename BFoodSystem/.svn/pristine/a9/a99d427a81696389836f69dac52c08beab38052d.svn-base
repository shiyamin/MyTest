//
//  BFFoodSearchController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/25.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodSearchController.h"
#import "BFSearchTextField.h"
#import "UIButton+BFRedButton.h"
#import "BFAddFoodCell.h"
#import "BFFoodClassModel.h"
#import "BFFoodModel.h"


@interface BFFoodSearchController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    BFSearchTextField *searchField;
}

@property(nonatomic, strong) UITableView *tabbleView;

@property(nonatomic, strong) NSMutableArray *searchArr;

@end

@implementation BFFoodSearchController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT - 134) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFAddFoodCell" bundle:nil] forCellReuseIdentifier:BFAddFoodCellIdentifier];
    }
    return _tabbleView;
}

- (NSMutableArray *)searchArr{
    if (!_searchArr) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜品搜索";
    [self setStatusForSubViews];
}

- (void)setStatusForSubViews{
    searchField = [BFSearchTextField searchBarWithTitle:@"请输入菜品名搜索" withImage:@"sy_sousuo"];
    [self.view addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(30);
    }];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.delegate = self;
    
    
    //搜索的but
    UIButton *searchBut = [UIButton configUniversalWithTitle:@"搜索" withNormalImageName:nil withHightImageName:nil withTitleColor:BF_COLOR_B10 withBgImage:nil withBgColor:nil];
    [searchBut addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBut];
    [searchBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    searchBut.layer.borderWidth = 1.0;
    searchBut.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
    searchBut.layer.cornerRadius = 5.0;
}


- (void)searchAction:(UIButton *)sender
{
    NSString *foodName = searchField.text;
    if([foodName isEqualToString:@""]){
        [BFUtils showAlertController:0 title:@"" message:@"请输入菜品名字"];
        return ;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFAddFoodCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAddFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAddFoodCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
