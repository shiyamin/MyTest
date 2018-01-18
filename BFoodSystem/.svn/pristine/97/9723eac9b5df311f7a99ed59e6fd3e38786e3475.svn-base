//
//  BFAreaMangerController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFAreaMangerController.h"
#import "BFAreaTabbleCell.h"
#import "BFShopServices.h"
#import "BFAreaModel.h"
#import "BJNoDataView.h"

@interface BFAreaMangerController ()<UITableViewDelegate,UITableViewDataSource,
    BFAreaTabbleCellDelegate>

@property (nonatomic, strong)UITableView *tabbleView;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic, strong) NSMutableArray *slectArr;

@property (nonatomic, assign) BOOL isEdit;

@end


@implementation BFAreaMangerController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, SCREEN_HEIGHT - 110) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        _tabbleView.tableFooterView = [[UIView alloc] init];
        _tabbleView.separatorColor = [UIColor clearColor];
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    }
    return _tabbleView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self addObserver:self forKeyPath:@"dataArr" options:NSKeyValueObservingOptionNew context:nil];
    _slectArr = [NSMutableArray array];
    self.dataArr=[NSMutableArray array];
    self.title = @"区域管理";
    [self setStatusForSubViews];
    [self getAreaListInfo];
}

- (void)back {
    if (_isEdit) {
        [self.view endEditing:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (NSString *message in _slectArr) {
                NSArray *arr = [message componentsSeparatedByString:@","];
                [[BFShopServices alloc] saveAreaInfoToServicesWithAreaId:[arr firstObject] areaName:[arr lastObject] SuccessBlock:^(id result) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];                   
                } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];
                } Failure:^(NSError *error) {
                    [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                }];
               
            }
             [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setStatusForSubViews{
    [self.view addSubview:self.tabbleView];
    [self.tabbleView registerNib:[UINib nibWithNibName:@"BFAreaTabbleCell" bundle:nil] forCellReuseIdentifier:BFAreaTabbleCellIdentifier];
    UIButton *newDeskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newDeskBtn setFrame:CGRectMake(0,SCREEN_HEIGHT - 110, SCREEN_WIDTH, 46)];
    [self.view addSubview:newDeskBtn];
    [newDeskBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    [newDeskBtn setTitle:@"新增区域" forState:UIControlStateNormal];
    [newDeskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newDeskBtn addTarget:self action:@selector(newBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getAreaListInfo{
    [[BFShopServices alloc] getDeskAreaInfoWithSuccessBlock:^(id result) {
       
        [self.dataArr removeAllObjects];
        self.dataArr = (NSMutableArray *)result;
        [self.tabbleView  reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];

    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];

    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BFAreaTabbleCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFAreaTabbleCell *cell = [tableView dequeueReusableCellWithIdentifier:BFAreaTabbleCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.delectBtn.tag = indexPath.row;
    cell.delegate = self;
    BFAreaModel *model =  self.dataArr[indexPath.row];
    cell.areaTextField.text = model.name;
    [cell.areaTextField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    cell.areaTextField.tag = [model.areaId integerValue];
    return cell;
}



- (void)newBtnClick:(UIButton *)sender{
    
    NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@""];
    [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
    [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"新增区域" preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:buttonTitle forKey:@"attributedTitle"];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入新的区域名字";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTf = alertController.textFields.firstObject;
        BFLog(@"新增区域名====%@", nameTf.text);
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if (nameTf.text.length<1) {
            return ;
        }
        [BFUtils showProgressHUDWithTitle:@"请求中..." inView:self.view animated:YES];
        [[BFShopServices alloc] saveAreaInfoToServicesWithAreaId:@"" areaName:nameTf.text SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"新增区域成功"];
            BFAreaModel *model = [[BFAreaModel alloc] init];
            model.name = nameTf.text;
            model.areaId = @"1";
            [self.dataArr addObject:model];
            [self.tabbleView reloadData];
            [self getAreaListInfo];
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        } Failure:^(NSError *error) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];

        }];
        
    }];
    
    
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tabbleViewCellDelectBtnAction:(UIButton *)button{
    BFAreaModel *model = self.dataArr[button.tag];
    NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:model.name];
    [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
    [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"确定需要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc setValue:buttonTitle forKey:@"attributedTitle"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[BFShopServices alloc] delectDeskAreaWithAreaId:model.areaId SuccessBlock:^(id result) {
            [BFUtils showAlertController:0 title:@"" message:@"删除区域成功"];
            [self.dataArr removeObjectAtIndex:button.tag];
            [self.tabbleView reloadData];
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        } Failure:^(NSError *error) {
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        }];
        
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark -- UITextFieldChange
- (void)textFieldDidChangeValue:(UITextField *)textField {
    _isEdit = YES;
    NSString *areaID = [NSString stringWithFormat:@"%ld,",(long)textField.tag];
    NSString *changeMessage = [areaID stringByAppendingString:textField.text];
    
    [_slectArr addObject:changeMessage];
}
#pragma mark-----KVO回调----
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"dataArr"]) {
        return;
    }
    if ([self.dataArr count]==0) {//无数据
        [[BJNoDataView shareNoDataView] showCenterWithSuperView:self.tabbleView icon:nil iconClicked:^{
            //图片点击回调
            [self getAreaListInfo];//刷新数据
        }];
        return;
    }
    //有数据
    [[BJNoDataView shareNoDataView] clear];
}
-(void)dealloc{
    //移除KVO
    [self removeObserver:self forKeyPath:@"dataArr"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
