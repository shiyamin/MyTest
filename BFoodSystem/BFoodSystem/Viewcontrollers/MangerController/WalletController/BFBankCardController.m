//
//  BFBankCardController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/4/1.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBankCardController.h"
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

@interface BFBankCardController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)BFTextFiledView *nameView;
@property (nonatomic, strong)BFTextFiledView *bankNumView;
@property (nonatomic, strong)BFTextFiledView *passwordView;

@property (nonatomic, strong)NSMutableArray *photoArr;
@property (nonatomic, strong)NSMutableArray *assertArr;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic,strong) UIButton *picBtn;

@property (nonatomic, copy) NSString *imageIdStr;


@end

@implementation BFBankCardController

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
    self.title = @"添加银行卡";
    [self setStatusForSubViews];
}


- (void)setStatusForSubViews{
    self.nameView = [[BFTextFiledView alloc] init];
    [self.nameView configImage:@"yhk_chikaren" textfiledPlaceholder:@"持卡人"];
    self.nameView.textfiled.userInteractionEnabled = NO;
    if ([BFUserSignelton shareBFUserSignelton].truename) {
        self.nameView.textfiled.text = [BFUserSignelton shareBFUserSignelton].truename;
    }
    [self.view addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.height.mas_equalTo(40);
    }];
    
    self.bankNumView = [[BFTextFiledView alloc] init];
    [self.bankNumView configImage:@"yhk_kahao" textfiledPlaceholder:@"卡号"];
    [self.view addSubview:self.bankNumView];
    [self.bankNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(self.nameView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-12);
        make.height.mas_equalTo(40);
    }];
    
//    self.passwordView = [[BFTextFiledView alloc] init];
//    [self.passwordView configImage:@"yhk_mima" textfiledPlaceholder:@"设置在平台的支付密码"];
//    [self.view addSubview:self.passwordView];
//    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
//        make.top.equalTo(self.bankNumView.mas_bottom).offset(10);
//        make.right.equalTo(self.view).offset(-12);
//        make.height.mas_equalTo(40);
//    }];
    
    UILabel *promptLable = [[UILabel alloc] init];
    promptLable.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    promptLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    promptLable.text = @"请拍摄银行卡正面";
    [self.view addSubview:promptLable];
    [promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNumView);
        make.right.equalTo(self.bankNumView);
        make.top.equalTo(self.bankNumView.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    
    self.picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.picBtn setBackgroundImage:[UIImage imageNamed:@"cp_tupian1"] forState:UIControlStateNormal];
    [self.picBtn addTarget:self action:@selector(pushToPhotoVController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.picBtn];
    [self.picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promptLable);
        make.top.equalTo(promptLable.mas_bottom).offset(5);
        make.width.height.mas_equalTo(100);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setButtonRedStatus];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.bottom.equalTo(self.view).offset(-12);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)commitBtnAction:(UIButton *)sender{
    NSString *bankNumStr = self.bankNumView.textfiled.text;
    if ([bankNumStr isEqualToString:@""]) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入银行卡账号"];
        return;
    }
    if ([self.imageIdStr isEqualToString:@""] || self.imageIdStr == nil) {
        [BFUtils showAlertController:0 title:@"" message:@"请上传银行卡照片"];
        return;
    }
    NSString *userName = [BFUserSignelton shareBFUserSignelton].truename;
    [BFUtils showProgressHUDWithTitle:@"" inView:self.view animated:YES];
    [[BFQueryServices alloc] saveBankInfoWithBankNum:bankNumStr bankImageId:self.imageIdStr personName:userName bankName:@"" SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        UIAlertController * alert = [BFUtils alertController:nil message:@"成功添加银行卡"];
        UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.withDrawVc getBankCardInfoList];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:confirm];
        
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];
}



- (void)pushToPhotoVController:(UIButton *)sender{
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
    [self uploadImage];
    
}


- (void)uploadImage{
    
    
    [BFUtils showProgressHUDWithTitle:@"上传中...." inView:self.view animated:YES];
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
            [BFUtils showAlertController:0 title:@"" message:@"图片上传成功"];
            [self.picBtn setImage:self.photoArr.firstObject forState:UIControlStateNormal];
            self.imageIdStr = idStr;
        }else{
            [uploadMsg appendString:@"张图片上传失败"];
            [BFUtils showAlertController:0 title:@"" message:uploadMsg];
        }
        
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
