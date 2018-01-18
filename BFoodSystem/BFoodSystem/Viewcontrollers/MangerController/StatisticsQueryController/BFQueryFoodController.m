//
//  BFQueryFoodController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFQueryFoodController.h"
#import "BFQueryFoodCell.h"
#import "BFQueryServices.h"
#import "BFQueryFoodModel.h"
#import "UIImageView+ZJFCustomImageView.h"

@interface BFQueryFoodController ()<BFDataSearchViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIImageView *showImageView;
@end

@implementation BFQueryFoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜品销量查询";
    

}

- (void)addSubviews{
    self.dataView.delegate = self;
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFQueryFoodCell" bundle:nil] forCellReuseIdentifier:BFQueryFoodCellIdentifier];
    self.tabbleView.showsVerticalScrollIndicator = NO;
    self.tabbleView.showsHorizontalScrollIndicator = NO;
    self.tabbleView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tabbleView.tableFooterView = [[UIView alloc] init];
    self.tabbleView.layer.cornerRadius = 5;
    self.tabbleView.layer.borderWidth = 1;
    self.tabbleView.clipsToBounds = YES;
    self.tabbleView.layer.borderColor = [UIColor clearColor].CGColor;
    [self.dataView hiddenTipsLableAndImage];
    
    
}





-(void)searchBtnActionWithBeginTime:(NSString *)beginStr endTime:(NSString *)endStr{
    BFLog(@"%@====%@", beginStr,endStr);
    
    [BFUtils showProgressHUDWithTitle:@"查询中..." inView:self.view animated:YES];
    [[BFQueryServices alloc] queryStatisticsDishesWithStartTime:beginStr endTime:endStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        self.dataArr = (NSMutableArray *)result;
        if (self.dataArr.count >0) {
            self.tabbleView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B10].CGColor;
        }else{
            self.tabbleView.layer.borderColor = [UIColor clearColor].CGColor;
        }
        if ([self.dataArr isKindOfClass:[NSMutableArray class]]
            && self.dataArr.count == 0) {
            _showImageView = [UIImageView showNonDateImageWithAddView:self.tabbleView];
            [_showImageView removeFromSuperview];
            [self.tabbleView addSubview:_showImageView];
        } else if (self.dataArr.count > 0) {
            [_showImageView removeFromSuperview];
            
        }
        [self.tabbleView  reloadData];    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFQueryFoodCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFQueryFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:BFQueryFoodCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFQueryFoodModel *model = self.dataArr[indexPath.row];
    [cell configFoodName:model.dishes_name saleNum:model.sales];
    return cell;
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
