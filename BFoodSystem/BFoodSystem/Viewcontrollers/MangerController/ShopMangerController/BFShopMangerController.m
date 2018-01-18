//
//  BFShopMangerController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/16.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFShopMangerController.h"
#import "BFShopServices.h"
#import "BFShopDetailModel.h"
#import "BFShopBottomCell.h"
#import "BFShopMangerMiddleCell.h"
#import "BFShopHeadView.h"
#import "BFUpImageController.h"
#import "BFShopDetailModel.h"
#import "ZJFAddTagCell.h"
#import "ZJFShowTagCell.h"
#import "ZJFUpTagController.h"
#import "ZJFEqualSpaceFlowLayout.h"
#import "SDWebImageManager.h"


@interface BFShopMangerController ()<
UITableViewDelegate,UITableViewDataSource,
BFShopHeadViewDelegate,
BFUpImageControllerDelegate,
BFShopBottomCellDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
ZJFEqualSpaceFlowLayoutDelegate,
UITextFieldDelegate,
UITextViewDelegate>

@property (nonatomic, strong)UITableView *tabbleView;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)BFShopHeadView *headView;

@property (nonatomic, copy) NSString *iconId;

@property (nonatomic, copy) NSString *picIds;

@property (nonatomic, strong) BFShopMangerMiddleCell *middleCell;

@property (nonatomic, strong) BFShopBottomCell *bottomCell;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, copy) NSString *foodType;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) NSArray *selectTag;

@property (nonatomic, copy) NSString *tabFee;

@property (nonatomic, copy) NSString *tagStr;

@property (nonatomic, strong) NSMutableArray *netTagArr;

@property (nonatomic, strong) UITextField *tagTextField;

@property (nonatomic, assign) BOOL  isEdit;
@end

@implementation BFShopMangerController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        _tabbleView = [[UITableView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        _tabbleView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
        _tabbleView.showsVerticalScrollIndicator = NO;
        _tabbleView.showsHorizontalScrollIndicator = NO;
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFShopBottomCell" bundle:nil] forCellReuseIdentifier:BFShopBottomCellIndertifier];
        [_tabbleView registerNib:[UINib nibWithNibName:@"BFShopMangerMiddleCell" bundle:nil] forCellReuseIdentifier:BFShopMangerMiddleCellIdentifier];
        _tabbleView.tableFooterView = [[UIView alloc] init];
        _tabbleView.separatorColor = [UIColor clearColor];
    }
    return _tabbleView;
}
- (NSArray *)netTagArr{
    if (!_netTagArr) {
        _netTagArr = [NSMutableArray array];
    }
    return _netTagArr;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopDetailInfoRequest];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.headView timerInvalidate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺管理";
    
    _selectTag = [NSArray array];
    [self setStatusForSubviews];
    [self configCollectionView];
    [self configNavgationRightItem];
    
}


#pragma mark -- 返回提示

- (void)back {
    
    if (_isEdit) {
        [self.view endEditing:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self rightBarSaveBtnAction];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)configNavgationRightItem{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarSaveBtnAction)];
    
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setStatusForSubviews{
    
    self.headView = [[BFShopHeadView alloc] init];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 250);
    self.headView.delegate = self;
    self.headView.shopTitleTF.delegate = self;

    self.tabbleView.tableHeaderView = self.headView;
    [self.headView configIcon:@"bf_icon" shopTitle:@"店铺标题"];
    [self.view addSubview:self.tabbleView];
    
}

- (void)configCollectionView {
    ZJFEqualSpaceFlowLayout *layout = [[ZJFEqualSpaceFlowLayout alloc] init];
    layout.delegate = self;
    self.collectionView.collectionViewLayout = layout;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, WIDTH_SCREEN, 85) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ZJFAddTagCell class] forCellWithReuseIdentifier:@"ZJFAddTagCell"];
    [_collectionView registerClass:[ZJFShowTagCell class] forCellWithReuseIdentifier:@"ZJFShowTagCell"];
    
}

//获取店铺详情信息
- (void)getShopDetailInfoRequest{
    
    
    [[BFShopServices alloc] getShopDetailInfoWithSuccessBlock:^(id result) {
        BFLog(@"店铺详情======%@", result);
        [self.collectionView reloadData];
        BFShopDetailModel *model = (BFShopDetailModel *)result;
        if (model.logo_url) {
            self.iconId = model.logo;
        } else {
            self.iconId = model.shopId;
        }
        self.picIds = model.pic_list;
        for (NSDictionary *dic in model.tagArr) {
            [self.netTagArr addObject:[dic objectForKey:@"name"]];
        }
        self.payType = model.payType;
        self.foodType = model.foodType;
        [self.headView configIcon:model.logo_url shopTitle:model.name];
        [self.headView configShopPicList:model.picArr];
        [self.middleCell configAddress:model.address avgPrice:model.avgprice openTime:model.openTime tel:model.tel];
        [self.bottomCell configTextView:model.shopDescription mealFee:model.tableFee tagArr:model.tagArr andBtnStauts:model.foodType payStatus:model.payType];
 
        [self.collectionView reloadData];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.netTagArr.count + 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.tabbleView.frame.size.width - 10*3)/3, 30);
    
}

- (CGRect)getStringRect:(NSString*)aString withFont :(CGFloat)font{
    CGRect rect = CGRectZero;
    if(aString){
        CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
        return  rect;
    }
    return rect;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.netTagArr.count) {
        ZJFAddTagCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZJFAddTagCell" forIndexPath:indexPath];
        [cell.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        return cell;
        
    } else {
        ZJFShowTagCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZJFShowTagCell" forIndexPath:indexPath];
        cell.tagLabel.text =  [self.netTagArr objectAtIndex:indexPath.row];
        return cell;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _isEdit = YES;
    if (indexPath.row == self.netTagArr.count) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入标签" preferredStyle:UIAlertControllerStyleAlert];
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框；
            _tagTextField = alertController.textFields.firstObject;
            [_tagTextField resignFirstResponder];
            if (_tagTextField.text == nil || _tagTextField.text == NULL || [_tagTextField.text isEqualToString:@""]) {
                
            } else {
                [self.netTagArr addObject:_tagTextField.text];
                [_collectionView reloadData];
                
            }
        }]];
        //增加取消按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        
        //定义第一个输入框；
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入标签";
        }];
        [self presentViewController:alertController animated:true completion:nil];
    } else {
        
        [self.netTagArr removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
    }
    
    
    
}


#pragma mark UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1){
        return 400;
    }else{
        return 150;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        BFShopBottomCell *cell = [_tabbleView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        if ([cell.contentView viewWithTag:999]) {
            self.tabFee = cell.mealFreeTF.text;
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        BFShopMangerMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:BFShopMangerMiddleCellIdentifier forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.middleCell = cell;
        
        cell.addressTf.delegate = self;
        cell.phoneTf.delegate = self;
        cell.averageTf.delegate = self;
        cell.timeTf.delegate = self;
        return cell;
    }else{
        BFShopBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:BFShopBottomCellIndertifier forIndexPath:indexPath];
        cell.layer.cornerRadius = 5;
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bottomCell = cell;
        [cell.tagView addSubview:_collectionView];
        cell.delegate = self;
//        cell.mealFreeTF.delegate = self;
        cell.textView.delegate = self;
        return cell;
    }
    
}
#pragma mark -- HeadViewDelegate
- (void)headViewPicItemAction:(NSIndexPath *)index{
    [self.view endEditing:YES];
    
    BFUpImageController *upVc = [[BFUpImageController alloc] init];
    upVc.allowUploadNum = 3;
    upVc.delegate = self;
    upVc.selectArrBlock = ^(NSMutableArray *selectArrBlock) {
        if (selectArrBlock) {
            _isEdit = YES;
        }
    };
    upVc.vcIdentifier = @"picUpload";
    [self.navigationController pushViewController:upVc animated:YES];
}

- (void)headIconAction{
    
    [self.view endEditing:YES];
    BFUpImageController *upVc = [[BFUpImageController alloc] init];
    upVc.allowUploadNum = 1;
    upVc.delegate = self;
    upVc.selectArrBlock = ^(NSMutableArray *selectArrBlock) {
        if (selectArrBlock) {
            _isEdit = YES;
        }
    };
    upVc.vcIdentifier = @"iconUpload";
    [self.navigationController pushViewController:upVc animated:YES];
    
}
#pragma mark -- BFShopBottomCellDelegate
- (void)payBtnAction:(UIButton *)btn payType:(NSString *)typeStr{
    
    if (btn.tag == 11 || btn.tag == 12) {
        if (![typeStr isEqualToString:self.payType]) {
            _isEdit = YES;
        }
        self.payType = typeStr;
    }else{
        if (![typeStr isEqualToString:self.foodType]) {
            _isEdit = YES;
        }
        self.foodType = typeStr;
    }
    

    
}

//保存信息
- (void)rightBarSaveBtnAction {
    
    [self.view endEditing:YES];
    NSString *shopName = self.headView.shopTitleTF.text;
    NSString *str = @"";
    
    for (NSString *tagStr in self.netTagArr) {
        str = [str stringByAppendingFormat:@"%@,",tagStr];
    }
    if (![str isEqualToString:@""]) {
        self.tagStr = [str substringToIndex:[str length] - 1];
    }
    
    
    if (self.tabFee == nil || self.tabFee == NULL) {
        self.tabFee = self.bottomCell.mealFreeTF.text;
    }
    if (self.tagStr == nil) {
        self.tagStr = @"";
    }


    [BFUtils showProgressHUDWithTitle:@"上传中...." inView:self.view animated:YES];
    [[BFShopServices alloc] postShopDetailInfoWithMerchaName:@"" merchaDescripment:@"" shopName:shopName logoId:self.iconId address:self.middleCell.addressTf.text tel:self.middleCell.phoneTf.text personAvgPrice:self.middleCell.averageTf.text opentime:self.middleCell.timeTf.text tableFee:self.tabFee shopDescripment:self.bottomCell.textView.text picIds:self.picIds tagStr:self.tagStr payType:self.payType foodType:self.foodType SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"店铺信息修改成功"];
        //        self.netTagArr = self.selectTag;
        _isEdit = NO;
        [_collectionView reloadData];
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
        
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}


- (void)uploadImageDidFinshWithId:(NSString *)idStr identifier:(NSString *)identifier photoArr:(NSArray *)photoArr{
    if ([identifier isEqualToString:@"iconUpload"]) {
        self.iconId = idStr;
        [self.headView configImage:photoArr.lastObject];
    }else if ([identifier isEqualToString:@"picUpload"]){
        self.picIds = idStr;
        [self.headView configShopPicListWithImageArr:photoArr];
    }
}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _isEdit = YES;
}
#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _isEdit = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
