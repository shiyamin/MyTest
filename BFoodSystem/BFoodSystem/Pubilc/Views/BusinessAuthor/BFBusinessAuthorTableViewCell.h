//
//  BFBusinessAuthorTableViewCell.h
//  BFoodSystem
//
//  Created by 浙江择富 on 2018/1/17.
//  Copyright © 2018年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFBusinessAuthorCellIndetifier @"BFBusinessAuthorCellIndetifier"


@interface BFBusinessAuthorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopContras;

@property(nonatomic,strong)UILabel *nameLab;

@property(nonatomic,strong)UILabel *tihsiLab1;

@property(nonatomic,strong)UILabel *tihsiLab2;

@property(nonatomic,strong)UIImageView *picImageView;

//***上传图片按钮
@property(nonatomic,strong)UIButton *upPhotoBtn;




@end
