//
//  BFNewDeskController.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFNewDeskController.h"
#import "BFAreaSelectController.h"
#import "BFShopServices.h"
#import "BFAreaModel.h"
#import <CoreImage/CoreImage.h>
#import <Photos/Photos.h>

@interface BFNewDeskController ()<UITextFieldDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NSArray *areaArr;

@property (strong, nonatomic) NSMutableArray *dataArr;

@property (strong, nonatomic)  BFAreaModel *areaModel;

@property (nonatomic, strong) BFDeskModel *deskMdoel;

@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL isChange;


@end

@implementation BFNewDeskController

- (BFDeskModel *)deskMdoel{
    if (!_deskMdoel) {
        _deskMdoel = [[BFDeskModel alloc] init];
    }
    return _deskMdoel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (self.deskType == newDeskTypeAdd) {
        self.title = @"新增餐台";
    }else if (self.deskType == newDeskTypeDetail){
      self.title = @"修改餐台信息";
    }
    self.isChange = NO;

    [self setStatusForSubviews];
    
}

- (void)back{
    if (self.isChange && self.deskType == newDeskTypeDetail ) {

          [self.view endEditing:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"您编辑了信息尚未保存，是否保存？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self submitBtnClick];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)setStatusForSubviews{
    self.topLable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    self.topLable.textColor = [UIColor colorWithHex:BF_COLOR_B3];
    
    NSArray *backViewArr = @[self.nameBcakView,self.numBackView,self.typeBackView,self.areaSelectBtn,self.submitBtn,self.delectBtn,self.saveImageBtn];
    for (UIView *view in backViewArr) {
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
    }
    
    NSArray *labArr = @[self.nameTitleLab,self.typeTitleLab,self.numTitleLab];
    for (UILabel *lable in labArr) {
        lable.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        lable.textColor = [UIColor colorWithHex:BF_COLOR_B5];
    }
    NSArray *tfArr = @[self.nameTf,self.numTf];
    for (UITextField *textFied in tfArr) {
        textFied.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
        textFied.textColor = [UIColor colorWithHex:BF_COLOR_B3];
        textFied.delegate = self;
    }
    
    [self.typeButton setTitleColor:[UIColor colorWithHex:BF_COLOR_B5] forState:UIControlStateNormal];
    self.typeButton.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
//    [self.typeButton setImage:[[UIImage imageNamed:@"shouqi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    CGFloat width = self.typeButton.frame.size.width;
    self.typeButton.tag = 999;
    [self.typeButton setImageEdgeInsets:UIEdgeInsetsMake(10, width - 85, 10, 10)];
    self.typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.areaSelectBtn setTitleColor:[UIColor colorWithHex:BF_COLOR_B5] forState:UIControlStateNormal];
    self.areaSelectBtn.titleLabel.font = [UIFont systemFontOfSize:BF_FONTSIZE_a2];
    [self.areaSelectBtn setImage:[[UIImage imageNamed:@"shouqi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.areaSelectBtn setImageEdgeInsets:UIEdgeInsetsMake(10, SCREEN_WIDTH - 80, 10, 10)];
    self.areaSelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.areaSelectBtn setTitle:@"选择区域" forState:UIControlStateNormal];
    self.areaSelectBtn.tag = 111;
    
    if (self.deskType == newDeskTypeAdd) {
        self.delectBtn.hidden = YES;
        self.saveImageBtn.hidden = YES;
    }else if (self.deskType == newDeskTypeDetail){
        
        [self.areaSelectBtn setTitle:self.deskMdoel.areaName forState:UIControlStateNormal];
        self.nameTf.text = self.deskMdoel.name;
        self.numTf.text = [NSString stringWithFormat:@"%@",self.deskMdoel.num];
//        self.typeTf.text = self.deskMdoel.type;
        [self.typeButton setTitle:self.deskMdoel.type forState:UIControlStateNormal];
        self.type = self.deskMdoel.type;
        [self.submitBtn setTitle:@"提交修改" forState:UIControlStateNormal];
        [self.submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.delectBtn setTitle:@"删除餐桌" forState:UIControlStateNormal];
        [self.delectBtn setBackgroundColor:[UIColor colorWithHex:BF_COLOR_B11]];
        [self.saveImageBtn setTitle:@"保存餐台二维码到手机相册" forState:UIControlStateNormal];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.isChange = YES;
}

- (void)setAreaBtnText:(NSString *)areaName areaId:(NSString *)areaid{
    self.isChange = YES;
    [self.areaSelectBtn setImage:[[UIImage imageNamed:@"shouqi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.areaSelectBtn setTitle:areaName forState:UIControlStateNormal];
    self.areaName = areaName;
    self.areaId = areaid;
    BFLog(@"ididi%@", areaid);
}

- (void)setDeskForType:(NSString *)typeName {
    self.isChange = YES;

//    [self.typeButton setImage:[[UIImage imageNamed:@"shouqi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.typeButton setTitle:typeName forState:UIControlStateNormal];
    self.type = typeName;
}


- (void)getAreaArrList:(NSArray *)areaArr areaId:(NSString *)areaId{
    self.areaArr = [NSArray arrayWithArray:areaArr];
    self.areaId = areaId;
}

- (void)getDeskDetail:(BFDeskModel *)model areaName:(NSString *)areaName{
    self.deskMdoel = model;
    self.deskMdoel.areaName = areaName;
    self.areaName = areaName;
}
- (IBAction)selectTypeBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    BFAreaSelectController *areaSelVc = [[BFAreaSelectController alloc] init];
    
    areaSelVc.modalPresentationStyle = UIModalPresentationPopover;
    areaSelVc.popoverPresentationController.delegate = self;
    areaSelVc.popoverPresentationController.sourceView = self.typeButton;
    areaSelVc.popoverPresentationController.sourceRect = CGRectMake(0, 0, sender.frame.size.width * 2-60, sender.frame.size.height-10);//箭头位置
    areaSelVc.popoverPresentationController.backgroundColor = [UIColor clearColor];
    areaSelVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    NSMutableArray *typeArr = [NSMutableArray array];
    NSArray *titleArr = @[@"圆桌",@"方桌"];
    for (NSInteger count = 0; count < 2; count ++) {
        BFAreaModel *model = [[BFAreaModel alloc] init];
        model.name = titleArr[count];
        [typeArr addObject:model];
    }
    [areaSelVc updateAreaWithDataArr:typeArr];
    areaSelVc.deskVc = self;
    self.addType = deskType;
//    [self.typeButton setImage:[[UIImage imageNamed:@"zhankai"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self presentViewController:areaSelVc animated:YES completion:nil];
}

- (IBAction)selectAreaBtnClick:(UIButton *)sender {
    
    if (self.areaArr.count == 0) {
        [BFUtils showAlertController:0 title:@"" message:@"暂无区域可供选择，请新增区域"];
        return;
    }
    BFAreaSelectController *areaSelVc = [[BFAreaSelectController alloc] init];
    self.addType = areaSelect;
    areaSelVc.modalPresentationStyle = UIModalPresentationPopover;
    areaSelVc.popoverPresentationController.delegate = self;
    areaSelVc.popoverPresentationController.sourceView = self.areaSelectBtn;
    areaSelVc.popoverPresentationController.sourceRect = CGRectMake(0, 0, sender.frame.size.width * 2-60, sender.frame.size.height-10);//箭头位置
    areaSelVc.popoverPresentationController.backgroundColor = [UIColor clearColor];
    areaSelVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [areaSelVc updateAreaWithDataArr:self.areaArr];
    areaSelVc.deskVc = self;
    [self.areaSelectBtn setImage:[[UIImage imageNamed:@"zhankai"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self presentViewController:areaSelVc animated:YES completion:nil];
    
}


-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return  UIModalPresentationNone;
}

- (IBAction)submitBtnClick {
    [self.view endEditing:YES];
    NSString *nameStr = self.nameTf.text;
    NSString *numStr = self.numTf.text;
    //    NSString *typeStr = nil;
    if (nameStr.length < 1) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入餐桌名字"];
        return;
    }
    if (numStr.length < 1) {
        [BFUtils showAlertController:0 title:@"" message:@"请输入餐桌人数"];
        return;
    }
    if (self.type.length < 1) {
        [BFUtils showAlertController:0 title:@"" message:@"请选择餐桌类型"];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",self.areaId] isEqualToString:@""]) {
        [BFUtils showAlertController:0 title:@"" message:@"请选择区域"];
        return;
    }
    NSString *deskId = @"";
    if (self.deskType == newDeskTypeDetail) {
        deskId = self.deskMdoel.deskId;
    }
    
    [BFUtils showProgressHUDWithTitle:@"请求中..." inView:self.view animated:YES];
    [[BFShopServices alloc] saveDeskInfoWithDeskName:nameStr personNum:numStr areaId:self.areaId deskType:self.type deskId:deskId SuccessBlock:^(id result) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        self.isChange = NO;
        
        if (self.deskType == newDeskTypeDetail) {
            [BFUtils showAlertController:0 title:@"" message:@"修改餐桌信息成功"];
        }else{
            [BFUtils showAlertController:0 title:@"" message:@"新增餐桌成功"];
        }
        
        self.deskMdoel = [[BFDeskModel alloc] init];
        [self.deskMdoel setValuesForKeysWithDictionary:(NSDictionary *)result];
        self.deskMdoel.areaName = self.areaName;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self creatQRCodeForDesk:self.deskMdoel];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        [self.deskMangerVc getAreaListInfo];
        [self.view endEditing:YES];
    } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:errorMessage];
    } Failure:^(NSError *error) {
        [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
        [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
        
    }];

}


- (IBAction)delectBtnAction:(UIButton *)sender {
    self.isChange = NO;
    [self.view endEditing:YES];
    NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
    [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"确定需要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc setValue:buttonTitle forKey:@"attributedTitle"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[BFShopServices alloc] delectDeskWithDeskId:self.deskMdoel.deskId SuccessBlock:^(id result) {
            [BFUtils hideProgressHUDInView:self.view delegate:self animated:YES afterDelay:0];
            UIAlertController * alert = [BFUtils alertController:nil message:@"删除餐桌成功"];
            UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.deskMangerVc getAreaListInfo];
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
        
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVc addAction:cancelAction];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


- (IBAction)saveImageBtnAction:(UIButton *)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self creatQRCodeForDesk:self.deskMdoel];
    });
}


-(void)creatQRCodeForDesk:(BFDeskModel *)deskModel{
    

    if (self.deskMdoel.qr_code == nil ) {
        self.deskMdoel = deskModel;
        self.deskMdoel.areaName = [[deskModel.area lastObject]
                                   objectForKey:@"name"];
    }
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    //将字符串转换成NSData
    //self.deskMdoel.qr_code
    NSData *data=[self.deskMdoel.qr_code dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:500.0];
}


//改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *QrImage = [UIImage imageWithCGImage:scaledImage];
    
    CGImageRelease(scaledImage);
    
    UIImage *bgQrIamge = [self image:QrImage addToImage:[UIImage imageNamed:@"bgImage"] toFrame:CGRectMake(100,220, 300, 300)];
    UIImage *textBgImage = [self text:[NSString stringWithFormat:@"%@%@",self.deskMdoel.areaName,self.deskMdoel.name] addToView:bgQrIamge toPoint:CGPointMake(80, 280)];

    UIImage *bgQrIamge_V = [self image:QrImage addToImage:[UIImage imageNamed:@"bgImage_V"] toFrame:CGRectMake(200,460, 330, 330)];
    UIImage *textBgImage_V = [self text:[NSString stringWithFormat:@"%@%@",self.deskMdoel.areaName,self.deskMdoel.name] addToView:bgQrIamge_V toPoint:CGPointMake(180, 210)];
    
    UIImage *bgQrIamge_H = [self image:QrImage addToImage:[UIImage imageNamed:@"bgImage_H"] toFrame:CGRectMake(80,135, 330, 330)];
    UIImage *textBgImage_H = [self text:[NSString stringWithFormat:@"%@%@",self.deskMdoel.areaName,self.deskMdoel.name] addToView:bgQrIamge_H toPoint:CGPointMake(65, 180)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self saveimage:textBgImage];
        
        [self saveimage:textBgImage_V];
        
        [self saveimage:textBgImage_H];
        
//        [BFUtils showAlertController:0 title:@"" message:@"保存成功！"];
    });

    
    return [[UIImage alloc] init];
    
}

- (UIImage*)image:(UIImage*)image addToImage:(UIImage*)bigImage toFrame:(CGRect )imageFrame{
    
    CGFloat w = bigImage.size.width;
    
    CGFloat h = bigImage.size.height;
    
    //bitmap上下文使用的颜色空间
    
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
    
    //绘制图形上下文
    
    CGContextRef ref =CGBitmapContextCreate(NULL, w, h,8,444* bigImage.size.width, colorSpace,kCGImageAlphaPremultipliedFirst);
    
    //给bigImage画图
    
    CGContextDrawImage(ref,CGRectMake(0,0, w, h), bigImage.CGImage);
    
    CGContextDrawImage(ref,imageFrame, image.CGImage);
    
    //合成图片
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(ref);
    
    //关闭图形上下文
    
    CGContextClosePath(ref);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ref);
    UIImage *smallImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return smallImage;
    
}


//将文字添加到图片上

- (UIImage*)text:(NSString*)text addToView:(UIImage*)image toPoint:(CGPoint)textPoint{
    
    //设置字体样式
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT"size:50];
    
    NSDictionary *dict =@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]};
    
    CGSize textSize = [text sizeWithAttributes:dict];
    
    //绘制上下文
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
    
//    int border =10;
    
    //  CGRect re = {CGPointMake(image.size.width- textSize.width- border, image.size.height- textSize.height- border), textSize};
    CGRect re = {textPoint, textSize};
    
    //此方法必须写在上下文才生效
    [text drawInRect:re withAttributes:dict];
    
    UIImage*newImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


// 保存图片到相册的简单方法
- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
//        NSLog(@"success = %d, error = %@", success, error);
        
    }];
}


//保存图片到相册的方法（保存到一个一个相册列表中）
-(void)saveimage:(UIImage *)image{

    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: {
                    //  保存图片到相册
                    [self saveImageIntoAlbumWith:image];
                    break;
                }
                case PHAuthorizationStatusDenied: {
                    if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                    [BFUtils showAlertController:0 title:@"" message:@"相册访问被拒绝，请在系统设置中打开权限。"];
                    break;
                }
                case PHAuthorizationStatusRestricted: {
                    [BFUtils showAlertController:0 title:@"" message:@"因系统原因，无法访问相册！"];
                    break;
                }       
                default:
                    break;
            }
        });
    }];


}


//保存图片到相册
-(void)saveImageIntoAlbumWith:(UIImage *)image
{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssetsWtih:image];
    // 获得相册
    PHAssetCollection *createdCollection = [self createdCollection];
    
    if (createdAssets == nil || createdCollection == nil) {
//        [BFUtils showAlertController:0 title:@"" message:@"保存失败！"];
        return;
    }
    // 将相片添加到相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    // 保存结果
    if (error) {
//        [BFUtils showAlertController:0 title:@"" message:@"保存失败！"];
    } else {
        if (self.deskType == newDeskTypeAdd) {
            
        }else if (self.deskType == newDeskTypeDetail){
//            [BFUtils showAlertController:0 title:@"" message:@"保存成功！"];
        }

       
    }
}


// 获得刚才添加到【相机胶卷】中的图片
-(PHFetchResult<PHAsset *> *)createdAssetsWtih:(UIImage *)image
{
    __block NSString *createdAssetId = nil;
    // 添加图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    if (createdAssetId == nil) return nil;
    // 在保存完毕后取出图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}


//获得【自定义相册】
-(PHAssetCollection *)createdCollection
{
    // 获取软件的名字作为相册的标题(如果需求不是要软件名称作为相册名字就可以自己把这里改成想要的名称)
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    // 代码执行到这里，说明还没有自定义相册
    __block NSString *createdCollectionId = nil;
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    if (createdCollectionId == nil) return nil;
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
}

- (void)dealloc {
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
