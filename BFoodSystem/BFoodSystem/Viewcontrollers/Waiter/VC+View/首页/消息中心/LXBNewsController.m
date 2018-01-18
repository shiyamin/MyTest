//
//  LXBNewsController.m

//
//  Created by mac on 2017/4/10.
//  Copyright © 2017年 binbin. All rights reserved.
//

#import "LXBNewsController.h"
#import "LXBNewsCell.h"
#import "LXBNewsModel.h"
#import "BFShopServices.h"
#import "BFMessageListModel.h"
#import "LXBComfirmOrderViewController.h"
#import "BFOrderServices.h"
#import "BFShopServices.h"
#import "BJNoDataView.h"


//#define Korder Khead@"GetMyOrderList/"

#define LXBColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height



@interface LXBNewsController ()<UITableViewDelegate,UITableViewDataSource,LXBComfirmOrderDelegate>
@property(nonatomic,strong)UITableView * myTable;
@property(nonatomic,strong)NSMutableArray * data;

@end

@implementation LXBNewsController
-(NSMutableArray *)data
{
    if(!_data)
    {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
    self.navigationItem.title = @"消息";
    [self loadData];
    [self creatTable];
    
}


#pragma mark - 加载数据, 显示信息
- (void)loadData
{
    [[BFShopServices alloc] getMessageListInfoWithMessageType:@"2" SuccessBlock:^(id result) {
        
        self.data = [(NSMutableArray *)result lastObject];
     
        [self.myTable reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
//        _showImageView = [UIImageView showNonDateImageWithAddView:self.myTable];
//        [_showImageView removeFromSuperview];
//        [self.myTable addSubview:_showImageView];
        
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
//        _showImageView = [UIImageView showNonDateImageWithAddView:self.myTable];
//        [_showImageView removeFromSuperview];
//        [self.myTable addSubview:_showImageView];
    }];
    
    
}

- (void)creatTable
{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    self.myTable.backgroundColor = LXBColorRGB(245, 245, 245);
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    [self.myTable registerClass:[LXBNewsCell class] forCellReuseIdentifier:@"LXBNewsCell"];
    self.myTable.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:self.myTable];
    
}



#define myTableDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LXBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXBNewsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.modle = self.data[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFMessageListModel * model = self.data[indexPath.row];
    return model.cellHeight + 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BFMessageListModel *selectModel = self.data[indexPath.row];
    NSString *status = [NSString stringWithFormat:@"%@",selectModel.status];
    if ([status isEqualToString:@"2"]) {
        
    } else if ([status isEqualToString:@"1"]) {
        
        if ([selectModel.content rangeOfString:@"呼叫"].location != NSNotFound) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:selectModel.content preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            // 呼叫消息处理
            NSString *messageID = [selectModel.data objectForKey:@"msg_id"];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[BFShopServices alloc] confirmCallMessageWithMessageId: messageID SuccessBlock:^(id result) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    
                    [BFUtils alertController:nil message:@"信息发送成功"];
                    if (![self.presentedViewController isBeingDismissed]) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                        [self loadData];
                    }
                    
                } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                } Failure:^(NSError *error) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                    
                }];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
        } else {
            LXBComfirmOrderViewController *orderVC = [[LXBComfirmOrderViewController alloc] init];
            orderVC.listModel = selectModel;
            orderVC.delegate = self;
            
            [self.navigationController pushViewController:orderVC animated:YES];
        }
        
    }
}

#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"data"]) {
        return;
    }
    if ([self.data count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.myTable icon:nil iconClicked:^{
            //图片点击回调
            [self loadData];//刷新数据
        }];
        return;
    }
    //有数据
    [[BJNoDataView shareNoDataView] clear];
}
-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"data"];
}




@end
