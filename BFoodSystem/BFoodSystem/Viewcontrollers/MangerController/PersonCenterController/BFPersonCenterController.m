//
//  BFPersonCenterController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFPersonCenterController.h"
#import "UIButton+BFRedButton.h"
#import "BFUpImageController.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BFTextFiledView.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "BFImageUploadServices.h"
#import "BFQueryServices.h"
#import "BFTextFiledView.h"
#import "BFRegistController.h"
#import "UIImageView+WebCache.h"
#import "BFUserServices.h"
#import "BFUserInfoModel.h"
#import "BFShopBottomCell.h"

@interface BFPersonCenterController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *photoArr;
@property (nonatomic, strong)NSMutableArray *assertArr;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, strong) UIButton *picBtn;
@property (nonatomic, strong) UIButton *ladyButton;
@property (nonatomic, strong) UIButton *maleButton;

@property (nonatomic, copy) NSString *imageIdStr;

@property (nonatomic, strong) UITextField *nickNameView;

@property (nonatomic, strong) UITableView *personCenterTableView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UILabel *cacheLabel;

@property (nonatomic, copy) NSString *sexId;
@property (nonatomic, copy) NSString *picId;
@property (nonatomic, copy) NSString *changeId;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, copy) NSString *phoneStr;

@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation BFPersonCenterController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (NSMutableArray *)photoArr{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)assertArr{
    if (!_assertArr) {
        _assertArr = [NSMutableArray array];
    }
    return _assertArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"个人中心";
    self.titleArray = @[@"修改密码",@"清理缓存",@"联系我们",@"官方微信"];
    self.imageArray = @[@"grzx_mima",@"grzx_huancun",@"grzx_dianhua",@"grzx_weixin"];
    [self getPersonDetailInfoRequest];
    [self setStatusForSubViews];
    self.personCenterTableView.rowHeight = (HEIGHT_SCREEN/2-70)/4;
    self.phoneStr = @"";
    
}

- (void)getPersonDetailInfoRequest {
    
    [[BFUserServices alloc] getPersonDetailInfoWithSuccessBlock:^(id result) {
        BFLog(@"个人详情===== %@", result);
        BFUserInfoModel *model = (BFUserInfoModel *)result;
        
        if (!model.headimgurl || [model.headimgurl isEqualToString:@""]) {
            [self.picBtn setImage:[UIImage imageNamed:@"xzdy_touxiang"] forState:UIControlStateNormal];
        } else {
            [self.picBtn sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] forState:UIControlStateNormal];
        }
        
        self.nickNameView.text = model.nickname;
        self.sexId = model.sex;
        self.changeId = model.sex;
        self.phoneStr = model.mobile;
        
        [self.ladyButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
        [self.maleButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
        
        
        if ([model.sex integerValue] == 0) {
            
            [self.ladyButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
            [self.maleButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
        } else if ([model.sex integerValue] == 1) {
            [self.ladyButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
            [self.maleButton setImage:[UIImage imageNamed:@"dm_xuanzhong"] forState:UIControlStateNormal];
        } else {
            [self.ladyButton setImage:[UIImage imageNamed:@"dm_xuanzhong"] forState:UIControlStateNormal];
            [self.maleButton setImage:[UIImage imageNamed:@"dm_xuanzhong_not"] forState:UIControlStateNormal];
        }
        [self.personCenterTableView reloadData];
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
    }];
}

- (void)setStatusForSubViews {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN/2-30)];
    headView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B1];
    [self.view addSubview:headView];
    
    self.picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.picBtn setBackgroundImage:[UIImage imageNamed:@"xzdy_touxiang"] forState:UIControlStateNormal];
    [self.picBtn addTarget:self action:@selector(pushToPhotoVController:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.picBtn];
    [self.picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_SCREEN/2-50);
        make.top.equalTo(headView).offset(30);
        make.width.height.mas_equalTo(80);
    }];
    
    UILabel *nickNameLabel = [[UILabel alloc] init];
    [headView addSubview:nickNameLabel];
    nickNameLabel.text = @"昵称";
    nickNameLabel.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    nickNameLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(55);
        make.top.equalTo(self.picBtn.mas_bottom).offset(32);
        make.width.height.mas_equalTo(30);
    }];
    
    self.nickNameView = [[UITextField alloc] init];
    [headView addSubview:self.nickNameView];
    _nickNameView.delegate = self;
    self.nickNameView.borderStyle = UITextBorderStyleRoundedRect;
    self.nickNameView.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.nickNameView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    [self.nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameLabel.mas_right).offset(10);
        make.top.equalTo(self.picBtn.mas_bottom).offset(32);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *genderLabel = [[UILabel alloc] init];
    [headView addSubview:genderLabel];
    genderLabel.text = @"性别";
    genderLabel.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    genderLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(55);
        make.top.equalTo(nickNameLabel.mas_bottom).offset(15);
        make.width.height.mas_equalTo(30);
        
    }];
    
    self.ladyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ladyButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    [self.ladyButton setTitle:@"女" forState:UIControlStateNormal];
    self.ladyButton.tag = 2;
    self.ladyButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.ladyButton addTarget:self action:@selector(genderSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ladyButton.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.ladyButton.layer.cornerRadius = 5;
    [self.ladyButton setTitleColor:[UIColor colorWithHex:BF_COLOR_B4] forState:UIControlStateNormal];
    [headView addSubview:self.ladyButton];
    [self.ladyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameView.mas_bottom).offset(10);
        make.left.equalTo(genderLabel.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    self.maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.maleButton addTarget:self action:@selector(genderSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    self.maleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    self.maleButton.layer.cornerRadius = 5;
    [self.maleButton setTitle:@"男" forState:UIControlStateNormal];
    self.maleButton.tag = 1;
    
    self.maleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.maleButton.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self.maleButton setTitleColor:[UIColor colorWithHex:BF_COLOR_B4] forState:UIControlStateNormal];
    [headView addSubview:self.maleButton];
    [self.maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameView.mas_bottom).offset(10);
        make.left.equalTo(self.ladyButton.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setButtonRedStatus];
    [submitBtn setTitle:@"保存修改" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(genderLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    
    
    self.personCenterTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.personCenterTableView.delegate = self;
    self.personCenterTableView.dataSource = self;
    [self.personCenterTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.personCenterTableView setLayoutMargins:UIEdgeInsetsZero];
    self.personCenterTableView.backgroundColor = [UIColor colorWithHex:BF_COLOR_B0];
    self.personCenterTableView.layer.cornerRadius = 5;
    self.personCenterTableView.layer.borderWidth = 1;
    self.personCenterTableView.layer.borderColor = [UIColor colorWithHex:BF_COLOR_B2].CGColor;
    [self.view addSubview:self.personCenterTableView];
    [self.personCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submitBtn.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
}


- (void)back {
    if (_isEdit) {
        [self.view endEditing:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self commitBtnAction];
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

- (void)genderSelect:(UIButton *)sender {
    
    _isEdit = YES;
    UIImage *image1 = [UIImage imageNamed:@"dm_xuanzhong_not"];
    UIImage *image2 = [UIImage imageNamed:@"dm_xuanzhong"];
    
    if (sender.tag == 1) {
        
        self.ladyButton.enabled = YES;
        [self.ladyButton setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.maleButton setImage:[image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.maleButton.enabled = NO;
        self.changeId = @"1";
    } else {
        self.maleButton.enabled = YES;
        [self.maleButton setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.ladyButton setImage:[image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.ladyButton.enabled = NO;
        self.changeId = @"2";
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _isEdit = YES;
}

- (void)commitBtnAction {
    
    [self.view endEditing:YES];
    NSString *nickNameStr = self.nickNameView.text;
    NSString *truename = @"";
    NSString *passwork = @"";
    NSString *oldPasswork = @"";
    
    //    if (self.nickNameView.text == nil) {
    //        nickNameStr = @"";
    //    }
    if (!self.nickNameView.text || [[NSString stringWithFormat:@"%@",self.nickNameView.text] isEqualToString:@""]) {
        nickNameStr = @"";
        
    }
    //    if (self.imageIdStr == nil) {
    //        self.imageIdStr = @"";
    //    }
    if (!self.imageIdStr || [[NSString stringWithFormat:@"%@",self.imageIdStr] isEqualToString:@""]) {
        self.imageIdStr = @"";
        
    }
    if (self.changeId && ![[NSString stringWithFormat:@"%@",self.changeId] isEqualToString:@""]) {
        self.sexId = self.changeId;
    }
    if (!self.sexId || [[NSString stringWithFormat:@"%@",self.sexId] isEqualToString:@""]) {
        [BFUtils showAlertController:0 title:@"" message:@"请选择性别"];
        return;
    } else {
        [BFUtils showProgressHUDWithTitle:@"上传中...." inView:self.view animated:YES];
        [[BFUserServices alloc] saveUserInfoWithHeadimg:self.imageIdStr userNickname:nickNameStr trueName:truename userSex:self.sexId password:passwork oldPassword:oldPasswork SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            //                UIAlertController * alert = [BFUtils alertController:nil message:@"修改成功"];
            //                UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                    [self.navigationController popViewControllerAnimated:YES];
            //                }];
            //                [alert addAction:confirm];
            [BFUtils showAlertController:0 title:@"" message:@"修改成功"];
            
        } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:errorMessage];
        } Failure:^(NSError *error) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
            
        }];
        
    }
}

- (void)pushToPhotoVController:(UIButton *)sender{
    //    _isEdit = YES;
    [self pushImagePickerController];
}

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    imagePickerVc.selectedAssets = self.assertArr; // optional, 可选的
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS8Later) {
        // 无权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            //            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    BFLog(@"获取的图片的详细信息===%@", info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error) {
            [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                    [tzImagePickerVc hideProgressHUD];
                    TZAssetModel *assetModel = [models firstObject];
                    if (tzImagePickerVc.sortAscendingByModificationDate) {
                        assetModel = [models lastObject];
                    }
                    
                    [self.assertArr addObject:assetModel.asset];
                    [self.photoArr addObject:image];
                }];
            }];
            
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.photoArr  = [photos mutableCopy];
    self.assertArr = [assets mutableCopy];
    if (1 <self.photoArr.count) {
        [BFUtils showAlertController:1 title:@"" message:[NSString stringWithFormat:@"只能上传%d张图片",1]];
        return;
    }
    
    [self uploadImage];
    
}


- (void)uploadImage{
    
    //    [BFUtils showProgressHUDWithTitle:@"上传中" inView:self.view animated:YES];
    [[BFImageUploadServices alloc] uploadImageWithImage:[NSArray arrayWithObject:self.photoArr.firstObject] parame:[NSArray arrayWithObject:self.assertArr.firstObject] completion:^(NSArray *resultArr) {
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
        if (isSuccess) {
            //            [BFUtils showAlertController:0 title:@"" message:@"图片上传成功"];
            [self.picBtn setImage:self.photoArr.firstObject forState:UIControlStateNormal];
            _isEdit = YES;
            self.imageIdStr = idStr;
        }else{
            //            [uploadMsg appendString:@"张图片上传失败"];
            [BFUtils showAlertController:0 title:@"" message:uploadMsg];
        }
        
    }];
    
    
}

#pragma mark -- UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"personCenterCell";
    
    [self.personCenterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
    cell.textLabel.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
    
    if (indexPath.row == 1) {
        self.cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, 0, WIDTH_SCREEN/2-60, cell.frame.size.height)];
        self.cacheLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a3];
        self.cacheLabel.textColor = [UIColor colorWithHex:BF_COLOR_B2];
        //        float tmpSize =  [[SDImageCache sharedImageCache] getSize];
        //
        ////        if (tmpSize > (1024 * 1024))
        ////        {
        ////            tmpSize = tmpSize / (1024 * 1024);
        ////
        ////        }
        ////        else if (tmpSize > 1024)
        ////        {
        ////            tmpSize = tmpSize / 1024;
        ////
        ////        }
        //        tmpSize = tmpSize / 1024.0 / 1024.0;
        //        if (tmpSize == 0) {
        //            self.cacheLabel.text = [NSString stringWithFormat:@"0M"];
        //        } else {
        //            self.cacheLabel.text = [NSString stringWithFormat:@"%.2fM",tmpSize];
        //        }
        self.cacheLabel.text = [NSString stringWithFormat:@"%.2fM",[self checkTmpSize]];
        
        self.cacheLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:self.cacheLabel];
        
    } else if (indexPath.row == 2) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, 0, WIDTH_SCREEN/2-60, cell.frame.size.height)];
        _phoneLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        _phoneLabel.textColor = [UIColor colorWithHex:BF_COLOR_B14];
        _phoneLabel.text = self.phoneStr;
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:_phoneLabel];
        
    } else if (indexPath.row ==3) {
        UILabel *wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN/2, 0, WIDTH_SCREEN/2-60, cell.frame.size.height)];
        wechatLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a1];
        wechatLabel.textColor = [UIColor colorWithHex:BF_COLOR_B14];
        wechatLabel.text = self.phoneStr;
        wechatLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:wechatLabel];
        wechatLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatTapAction:)];
        [wechatLabel addGestureRecognizer:tapGesture];
    }
    
    return cell;
    
}

- (void)wechatTapAction:(UITapGestureRecognizer *)tap
{
    [BFUtils showAlertController:0 title:@"" message:@"复制到粘贴板成功"];
    UIPasteboard* pasteboard = [UIPasteboard pasteboardWithName:UIPasteboardNameGeneral create:YES];
    [pasteboard setString:@"1684646814"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        BFRegistController *registVC = [[BFRegistController alloc] init];
        registVC.selfType = @"changPsd";
        [self.navigationController pushViewController:registVC animated:YES];
    } else if (indexPath.row == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清理缓存" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache] clearDisk];
            self.cacheLabel.text = [NSString stringWithFormat:@"0.00M"];
            //            [self.personCenterTableView reloadData];
            //            [self clearTmpPics];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]]];
    }
}

- (float)checkTmpSize
{
    float tmpSize =  [[SDImageCache sharedImageCache] getSize];
    
    tmpSize = tmpSize / 1024.0 / 1024.0;
    
    NSLog(@"tmp size is %.2f",tmpSize);
    //
    return tmpSize;
    
    
}

#pragma 清理缓存图片

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
