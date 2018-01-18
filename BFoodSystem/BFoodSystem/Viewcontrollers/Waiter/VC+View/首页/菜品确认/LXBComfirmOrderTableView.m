//
//  LXBComfirmOrderTableView.m
//  01 点餐页面
//
//  Created by binbin on 2017/4/14.
//  Copyright © 2017年 XM. All rights reserved.
//

#import "LXBComfirmOrderTableView.h"
#import "BFAddFoodCell.h"
#import "ZJFConfirmListModel.h"
@interface LXBComfirmOrderTableView  ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LXBComfirmOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self configUI];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)configUI
{
    //注册cell;
    CGFloat tbHeight = SCREEN_HEIGHT - 186;
    CGFloat cellHeight = 80*(self.dataListArr.count) + 40;
    self.frame = CGRectMake(0, 0, WIDTH_SCREEN,cellHeight < tbHeight ? cellHeight : tbHeight );
    [self registerNib:[UINib nibWithNibName:@"BFAddFoodCell" bundle:nil] forCellReuseIdentifier:BFAddFoodCellIdentifier];
    
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFAddFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAddFoodCellIdentifier forIndexPath:indexPath];
    ZJFConfirmListModel *model = self.dataListArr[indexPath.row];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell configFoodIcon:[model.picUrlArr firstObject]];
    [cell configFoodName:model.name foodPrice:model.price foodNum:model.quantity];
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LXBConfirmtbHeadView *headView = [LXBConfirmtbHeadView headerInitialize:tableView];
//    headView.backgroundColor = [UIColor redColor];
    headView.deskName.numberOfLines = 0;
    headView.deskName.lineBreakMode = NSLineBreakByWordWrapping;
    headView.deskName.text= [NSString stringWithFormat:@"%@区大厅%@号桌 用餐人数:%@人",self.area_name,self.desk_name,self.dining_number];
    NSString *Pstatus = [NSString stringWithFormat:@"%@",self.payStatus];
    if ([Pstatus isEqualToString:@"1"]) {
        headView.payShow.text = [NSString stringWithFormat:@""];

    } else if([Pstatus isEqualToString:@"2"]){
        headView.payShow.text = [NSString stringWithFormat:@"已付款"];
    }
    headView.payShow.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
    headView.payShow.textAlignment = NSTextAlignmentRight;
    return headView;
}


@end


#pragma mark - tbview的头视图的使用

@interface LXBConfirmtbHeadView ()

@end
@implementation LXBConfirmtbHeadView
//headView 自定义注册的方法,外面不需要再注册 
+ (instancetype)headerInitialize:(UITableView *)tableView {
    static NSString *headerID = @"LXBComfirmCellID";
    LXBConfirmtbHeadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (header == nil) {
        header = [[LXBConfirmtbHeadView alloc] initWithReuseIdentifier:headerID];
    }
    return header;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self lxbCreationView];
    }
    return self;
}

- (void)lxbCreationView
{
    self.contentView.backgroundColor = [UIColor clearColor];
    _payShow = [[UILabel alloc] init];

    [self.contentView addSubview:_payShow];
    [_payShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    _deskName = [[UILabel alloc] init];
//    _deskName.adjustsFontSizeToFitWidth = YES;
    _deskName.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self.contentView addSubview:_deskName];
    [_deskName  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(_payShow.mas_left).with.offset(-10);
        make.height.mas_equalTo(40);
    }];
//    _deskName.text = @"A区大厅1号桌 用餐人数: 2人";
}




@end
