//
//  BFFoodClassPopController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/27.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodClassPopController.h"
#import "BFFoodClassModel.h"


@interface BFFoodClassPopController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *addArray;




@end

@implementation BFFoodClassPopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)updateAreaWithDataArr:(NSArray *)dataArr{
    self.addArray = [dataArr mutableCopy];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.vcIdentifier isEqualToString:@"addFood"]){
        return self.addArray.count;
    }
    return self.addArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
     if (indexPath.row == self.addArray.count) {
        cell.textLabel.text = @"分类管理";
    }else{
        BFFoodClassModel *classModel = self.addArray[indexPath.row];
        cell.textLabel.text = classModel.name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = @"";
    if (indexPath.row == self.addArray.count) {
        type = @"new";
    }
    if (self.delegate || [self.delegate respondsToSelector:@selector(didSelectRowAtIndex:andSelectType:)]) {
        [self.delegate didSelectRowAtIndex:indexPath andSelectType:type];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
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
