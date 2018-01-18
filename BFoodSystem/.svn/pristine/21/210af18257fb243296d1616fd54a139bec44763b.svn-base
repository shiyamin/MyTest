//
//  BFNewDeskController.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/21.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFDeskModel.h"
#import "BFDeskMangerController.h"



typedef enum : NSUInteger {
    newDeskTypeAdd,
    newDeskTypeDetail,
} newDeskType;

typedef enum : NSUInteger {
    areaSelect,
    deskType,
} newAddDeskType;

@interface BFNewDeskController : BFBaseViewController


@property (weak, nonatomic) IBOutlet UILabel *topLable;


@property (weak, nonatomic) IBOutlet UILabel *nameTitleLab;

@property (weak, nonatomic) IBOutlet UIView *nameBcakView;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;

@property (weak, nonatomic) IBOutlet UILabel *numTitleLab;

@property (weak, nonatomic) IBOutlet UIView *numBackView;
@property (weak, nonatomic) IBOutlet UITextField *numTf;

@property (weak, nonatomic) IBOutlet UILabel *typeTitleLab;

@property (weak, nonatomic) IBOutlet UIView *typeBackView;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
//@property (weak, nonatomic) IBOutlet UITextField *typeTf;

//@property (weak, nonatomic) IBOutlet UILabel *waiterTitleLab;
//
//@property (weak, nonatomic) IBOutlet UIView *waiterBackView;
//
//@property (weak, nonatomic) IBOutlet UITextField *waiterTf;


@property (weak, nonatomic) IBOutlet UIButton *areaSelectBtn;


@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@property (weak, nonatomic) IBOutlet UIButton *delectBtn;


@property (weak, nonatomic) IBOutlet UIButton *saveImageBtn;


@property (assign, nonatomic) newDeskType deskType;
@property (assign, nonatomic) newAddDeskType addType;

@property (strong, nonatomic) BFDeskMangerController *deskMangerVc;


- (void)getAreaArrList:(NSArray *)areaArr areaId:(NSString *)areaId;

- (void)getDeskDetail:(BFDeskModel *)model areaName:(NSString *)areaName;

- (void)setAreaBtnText:(NSString *)areaName areaId:(NSString *)areaid;

- (void)setDeskForType:(NSString *)typeName;
@end
