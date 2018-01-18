//
//  BFAreaSelectController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAreaSelectController.h"
#import "BFAreaModel.h"

@interface BFAreaSelectController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *addArray;



@end

@implementation BFAreaSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor colorWithHex:BF_COLOR_B10];
}

- (void)updateAreaWithDataArr:(NSArray *)dataArr{
    self.addArray = [dataArr mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }

    BFAreaModel *areaModel = self.addArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", areaModel.name];
    cell.textLabel.textColor = [UIColor colorWithHex:BF_COLOR_B10];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BFAreaModel *areaModel = self.addArray[indexPath.row];
    if (self.deskVc.addType == areaSelect) {
        [self.deskVc setAreaBtnText:areaModel.name areaId:areaModel.areaId];
    } else if (self.deskVc.addType == deskType) {
        [self.deskVc setDeskForType:areaModel.name];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = SCREEN_WIDTH - 30;
        if (tempSize.height>400) {
            tempSize.height = 400;
        }
        [self.tableView setFrame:CGRectMake(0, 0, tempSize.width, tempSize.height)];
        CGSize size = [self.tableView sizeThatFits:tempSize];  //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        return size;
    }else {
        return [super preferredContentSize];
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
