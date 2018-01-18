//
//  BFMassMessageController.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/6.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFMassMessageController.h"
#import "ZJFTextViewCell.h"
#import "BFUpImageController.h"
#import "BFShopServices.h"
#import "BFFoodClassModel.h"
#import "BFImageUploadServices.h"
#import "BFFoodTypeModel.h"
#import "ZJFMessageTextFieldCell.h"



@interface BFMassMessageController ()<
    UITableViewDelegate,
    UITableViewDataSource,
    BFUpImageControllerDelegate,
    UITextFieldDelegate,
    UITextViewDelegate>



@property (nonatomic, strong) UITableView *tabbleView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) BFUpImageController *upImageVc;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSArray *photoAsset;

@property (nonatomic, strong) ZJFMessageTextFieldCell *topCell;
@property (nonatomic, strong) ZJFTextViewCell *textCell;

@property (nonatomic, strong) NSMutableArray *foodClassArr;

@property (nonatomic, strong) NSMutableArray *foodTypeArr;

@property (nonatomic ,strong) NSMutableArray *picIdsArr;

@property (nonatomic, copy) NSString *picIdStr;

@property (nonatomic, assign) BOOL isEdit;

@end

@implementation BFMassMessageController

- (UITableView *)tabbleView{
    if (!_tabbleView) {
        CGRect frame ;
        
            frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 120);
        _tabbleView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tabbleView.delegate = self;
        _tabbleView.dataSource = self;
        [_tabbleView registerClass:[ZJFTextViewCell class] forCellReuseIdentifier:ZJFTextViewCellIdentifier];
        [_tabbleView registerClass:[ZJFMessageTextFieldCell class] forCellReuseIdentifier:BFTextFieldCellIdentifier];
        _tabbleView.tableFooterView = [[UIView alloc] init];
        _tabbleView.separatorColor = [UIColor clearColor];
    }
    return _tabbleView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)foodClassArr{
    if (!_foodClassArr) {
        _foodClassArr = [NSMutableArray array];
    }
    return _foodClassArr;
}

- (NSMutableArray *)foodTypeArr{
    if (!_foodTypeArr) {
        _foodTypeArr = [NSMutableArray array];
    }
    return _foodTypeArr;
}

- (NSMutableArray *)picIdsArr{
    if (!_picIdsArr) {
        _picIdsArr = [NSMutableArray array];
    }
    return _picIdsArr;
}

- (NSString *)picIdStr{
    if (!_picIdStr) {
        _picIdStr = [NSString string];
    }
    return _picIdStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群发消息";
    [self setStatusForSubViews];
    [self addUpImageViewForTableFootView];
    [self configDefaultInfo];
}

#pragma mark -- 返回提示

- (void)back {
    if (_isEdit) {
        [self.view endEditing:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self submitAction];
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
}

- (void)addUpImageViewForTableFootView{
    self.upImageVc = [[BFUpImageController alloc] init];
    self.upImageVc.vcIdentifier = @"BFAddFoodDetailController";
    self.upImageVc.delegate = self;
    self.upImageVc.imageType = upImageTypeImage;
    [self addChildViewController:self.upImageVc];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"开始群发" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B10]];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.clipsToBounds = YES;
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset (-10);
        make.height.mas_equalTo(40);
    }];
    
    
}

-  (void)configDefaultInfo{

    NSMutableArray *imaArr = [NSMutableArray array];
//    for (NSString *urlStr in self.foodModel.pic_url) {
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
//        UIImage *result = [UIImage imageWithData:data];
//        [imaArr addObject:result];
//    }
    self.photoArr = imaArr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }else if(indexPath.row == 1){
        return ZJFTextViewCellHeight;
    }else{
        return 340;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tabCell;
    if (indexPath.row == 0) {
        ZJFMessageTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:BFTextFieldCellIdentifier forIndexPath:indexPath];
        [cell configImage:@"xx_biaoti" textfiledPlaceholder:@"请输入标题"];
        cell.textfiled.delegate = self;
        self.topCell  = cell;
        tabCell = cell;
    }else if(indexPath.row == 1){
        ZJFTextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:ZJFTextViewCellIdentifier forIndexPath:indexPath];
        textCell.textView.delegate = self;
        self.textCell = textCell;
        [textCell textViewPlacehodel];
        tabCell = textCell;
    }else{
        
        tabCell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
        if (!tabCell) {
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        }
        [self.upImageVc updtaCollectionViewWithPhotoArr:self.photoArr];
        [tabCell addSubview:self.upImageVc.view];
        
    }
    tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tabCell;
}


- (void)didSelectImageArr:(NSArray *)photoArr imageInfoArr:(NSArray *)photoAsset identifier:(NSString *)identifier{
    _isEdit = YES;
    if ([identifier isEqualToString:@"BFAddFoodDetailController"]) {
        [self savePhoto:photoArr photoAsset:photoAsset];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.photoArr];
//        [arr addObjectsFromArray:photoArr];
        [self.photoArr addObjectsFromArray:photoArr];

        [self.upImageVc updtaCollectionViewWithPhotoArr:self.photoArr];
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


- (void)savePhoto:(NSArray *)photoArr photoAsset:(NSArray *)photoAsset{
    [BFUtils showProgressHUDWithTitle:@"图片上传中..." inView:self.view animated:YES];
    [[BFImageUploadServices alloc] uploadImageWithImage:photoArr parame:photoAsset completion:^(NSArray *resultArr) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        BOOL isSuccess = YES;
        NSMutableString *uploadMsg = [NSMutableString stringWithString:@"第"];
        NSMutableString *idStr = [NSMutableString string];
        for (int i= 0;i < resultArr.count; i++) {
            NSDictionary *resdic = resultArr[i];
            if([[resdic objectForKey:@"code"] integerValue]!=0){
                isSuccess = NO;
                NSString *numStr;
                if (i==resultArr.count -1) {
                    numStr  = [NSString stringWithFormat:@"%d",i +1];
                }else{
                    numStr  = [NSString stringWithFormat:@"%d,",i + 1];
                }
                [uploadMsg appendString:numStr];
            }else{
                NSArray *imageArr = [[resdic objectForKey:@"data"] objectForKey:@"list"];
                if (i==resultArr.count-1) {
                    [idStr appendString:[NSString stringWithFormat:@"%@",[imageArr.lastObject objectForKey:@"id"]]];
                }else{
                    [idStr appendString:[NSString stringWithFormat:@"%@,",[imageArr.lastObject objectForKey:@"id"]]];
                }
            }
        }
        if (![idStr isEqualToString:@""]) {
            self.picIdStr = [NSString stringWithFormat:@"%@,%@",self.picIdStr,idStr];
            self.picIdsArr = [[self.picIdStr componentsSeparatedByString:@","] mutableCopy];
        }
        
        
        if (isSuccess) {
//            [BFUtils showAlertController:0 title:@"" message:@"图片上传成功"];
        }else{
            [uploadMsg appendString:@"张图片上传失败"];
//            [BFUtils showAlertController:0 title:@"" message:uploadMsg];
        }
    }];
    
}

- (void)delectPhotoWhitIndex:(NSInteger)index{
    [self.photoArr removeObjectAtIndex:index];
    [self.picIdsArr removeObjectAtIndex:index];
    self.picIdStr = [self appendPicIdsWithArr:self.picIdsArr];
    BFLog(@"picIdStr===%@", self.picIdStr);
}


- (void)clearFoodInfo{
    [self.textCell textViewPlacehodel];
    [self.photoArr removeAllObjects];
    self.photoAsset = @[];
    [self.upImageVc updtaCollectionViewWithPhotoArr:self.photoArr];
}

// 将要上传的图片id拼接成字符串
- (NSString *)appendPicIdsWithArr:(NSArray *)picArr{
    NSMutableString *str = [NSMutableString string];
    for (NSInteger count = 0; count < picArr.count; count ++) {
        NSString *picid = picArr[count];
        if (count == picArr.count -1) {
            [str appendString:[NSString stringWithFormat:@"%@",picid]];
        }else{
            [str appendString:[NSString stringWithFormat:@"%@,",picid]];
        }
    }
    return str;
}

- (void)submitAction{
    
    NSString *messageTitle = self.topCell.textfiled.text;
    NSString *messageDetail = self.textCell.textView.text;
    self.picIdStr = [self appendPicIdsWithArr:self.picIdsArr];

    
    BFLog(@"messagetitle = %@/n,messageDetail = %@/n,picStr = %@",messageTitle,messageDetail,self.picIdStr);

    [BFUtils showProgressHUDWithTitle:@"保存中..." inView:self.view animated:YES];
    [[BFShopServices alloc] saveMessageInfoWithMessageTitle:messageTitle messageDescription:messageDetail picList:self.picIdStr SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"信息发送成功"];
        _isEdit = NO;
         [self.clientVc getMessageInfoRequest];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];

    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];

    }];

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
