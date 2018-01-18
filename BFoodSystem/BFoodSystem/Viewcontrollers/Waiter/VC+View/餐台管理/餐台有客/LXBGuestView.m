//
//  LXBGuestView.m
//  餐台管理
//
//  Created by DAYOU on 2017/4/6.
//  Copyright © 2017年 luoxingbin. All rights reserved.
//

#import "LXBGuestView.h"
#import "LXBsubtotalViewController.h"
#import "LXBDidOrderViewController.h"
#import "LXBOrder_listModel.h"
#import "BFDeskModel.h"

#import "BFDeskAreaServices.h"

#import "BFOrderServices.h"
#import "BFShopServices.h"

#import "BFPaymentWayController.h"

#define spacing 10
#define margin 15
#define buttonHeight 40
@interface LXBGuestView ()

@property(nonatomic,strong)UIButton * state;
@property(nonatomic,strong)LXBDidOrderViewController * didOrderVC;
@property (nonatomic, strong) NSString *mealCount;

@property(nonatomic, strong) NSMutableString *orderIds;


@end
@implementation LXBGuestView


#pragma mark - 对象销毁

- (NSMutableString *)orderIds{
    if (!_orderIds) {
        _orderIds = [NSMutableString string];
    }
    return _orderIds;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 2) {
            _dataArray = @[@{@"id":@"10",@"title":@"已下单"},
                           @{@"id":@"11",@"title": @"修改用餐人数"},
                           @{@"id":@"12",@"title":@"清台"},
                           @{@"id":@"13",@"title":@"催菜"},
                           @{@"id":@"14",@"title":@"消费小计"}
                           ];
        }else{
            _dataArray = @[@{@"id":@"9",@"title":@"结账"},
                           @{@"id":@"10",@"title":@"已下单"},
                           @{@"id":@"11",@"title": @"修改用餐人数"},
                           @{@"id":@"12",@"title":@"清台"},
                           @{@"id":@"13",@"title":@"催菜"},
                           @{@"id":@"14",@"title":@"消费小计"}
                           ];
        }
    }
    return _dataArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
}
    return self;
}

-(void)setMessageDic:(NSDictionary *)messageDic{
	_messageDic = messageDic;
	[self loadData];
}
- (void)loadData
{
	NSString *deskId = self.messageDic[@"deskId"];
	[[BFDeskAreaServices alloc] getDeskDetailWithDeskId:deskId SuccessBlock:^(id result) {

		NSArray *deskDetailArr = (NSArray *) result;
		self.dataArr = deskDetailArr;
        BFDeskModel *deskModel = self.dataArr.lastObject;
        NSInteger count = 0;
        for (LXBOrder_listModel *lxbModel in deskModel.order_list) {
            if ([lxbModel.status integerValue] == 1) {
                if (count == deskModel.order_list.count) {
                    [self.orderIds appendFormat:@"%@",lxbModel.order_id];
                }else {
                    [self.orderIds appendFormat:@"%@,",lxbModel.order_id];
                }
            }
            count ++;
        }
        
	} errorCode:^(NSInteger errorCode, NSString *errorMessage) {
		[BFUtils showAlertController:0 title:@"" message:errorMessage];
	} Failure:^(NSError *error) {
		[BFUtils showAlertController:0 title:@"" message:@"网路错误"];
	}];
}


-(void)createUI{
	
    //未支付的状态
    _state = [UIButton buttonWithType:UIButtonTypeCustom];
    _state.userInteractionEnabled = NO;
    _state.layer.cornerRadius = 5;
    _state.layer.masksToBounds = YES;
    _state.hidden = YES;
    NSAttributedString * normal = [[NSAttributedString alloc]initWithString:@"未支付" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:BF_FONTSIZE_a2],NSForegroundColorAttributeName:[UIColor colorWithHex:BF_COLOR_B1]}];
    NSAttributedString * select = [[NSAttributedString alloc]initWithString:@"已支付" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:BF_FONTSIZE_a2],NSForegroundColorAttributeName:[UIColor colorWithHex:BF_COLOR_B1]}];
    [_state setAttributedTitle:normal forState:UIControlStateNormal];
    [_state setAttributedTitle:select forState:UIControlStateSelected];
   	
    _state.titleEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8);
    
    [_state setBackgroundImage:[self createImageWithColor:[UIColor colorWithHex:BF_COLOR_B11]] forState:UIControlStateNormal];
    [_state setBackgroundImage:[self createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    
    [self addSubview:_state];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.top.equalTo(self.mas_top).with.offset(margin);
        make.width.with.offset(65);
        make.height.with.offset(22);
//        make.width.with.offset(_state.titleLabel.font.pointSize * _state.titleLabel.text.length + 32);
//        make.height.with.offset(_state.titleLabel.font.pointSize+8);
    }];
    
    //循环创建按钮
//    if (self.dataArr) {
        for (NSDictionary *titleDic in self.dataArray) {
            [self creatButtonWithTitle:[titleDic objectForKey:@"title"] Num:[[titleDic objectForKey:@"id"] integerValue]];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNewData) name:@"LXBCancelFoodNotification" object:nil];

    
}
-(void)reloadNewData{
	NSString *deskId = self.messageDic[@"deskId"];
	[[BFDeskAreaServices alloc] getDeskDetailWithDeskId:deskId SuccessBlock:^(id result) {
		NSArray *deskDetailArr = (NSArray *) result;
		self.dataArr = deskDetailArr;
		_didOrderVC.dataArr = _dataArr;
	} errorCode:^(NSInteger errorCode, NSString *errorMessage) {
		[BFUtils showAlertController:0 title:@"" message:errorMessage];
	} Failure:^(NSError *error) {
		[BFUtils showAlertController:0 title:@"" message:@"网路错误"];
	}];
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    BFDeskModel *deskModel = [self.dataArr lastObject];
    //设置已付和未付的状态
    if (deskModel.isPay) {
        NSString *ispay = [NSString stringWithFormat:@"%@",deskModel.isPay];
        [[BFUserSignelton shareBFUserSignelton] setIsPay:ispay];
    }
 
    if (deskModel == nil) {
        return;
    }else {
        _state.selected = [deskModel.isPay boolValue];

    }
    _mealCount = deskModel.num;
    _state.hidden = NO;
    
    UIButton *payBtn = (UIButton *)[self viewWithTag:9];
    if ([[BFUserSignelton shareBFUserSignelton].isPay integerValue] == 1) {
        [payBtn setBackgroundColor:[UIColor lightGrayColor]];
        payBtn.enabled = NO;
    }
}

-(void)creatButtonWithTitle:(NSString *)title Num:(NSInteger)num{

    

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSAttributedString * normal = [[NSAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:BF_FONTSIZE_a2],NSForegroundColorAttributeName:[UIColor colorWithHex:BF_COLOR_B0]}];
    [btn setAttributedTitle:normal forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:227/255.0 green:92/255.0 blue:48/255.0 alpha:1]];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.tag =  num;

    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat height;
    height  = buttonHeight + spacing;
    [self addSubview:btn];

    if ([[BFUserSignelton shareBFUserSignelton].loginType integerValue] == 2) {
        num = num - 10;  //-10
    }else{
        num = num - 9;
    }
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_state.mas_bottom).with.offset(margin + height * num);
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.right.equalTo(self.mas_right).with.offset(-margin);
        make.height.with.offset(buttonHeight);
    }];
    
    
}


-(void)buttonAction:(UIButton *)btn{
//    1.最简单的处理方式
//    2.可以用到数组元素为SEL
//    其实都差不多
    BFDeskModel *deskModel = [self.dataArr lastObject];
    LXBOrder_listModel *listModel = [deskModel.order_list firstObject];
    switch (btn.tag) {
        case 9:
        {
            LXBsubtotalViewController *subtotalVC = [[LXBsubtotalViewController alloc] init];
            subtotalVC.messageDic = self.messageDic;
            subtotalVC.dataArr = self.dataArr;
            subtotalVC.orderIds = self.orderIds;
            UINavigationController *nagVC = (UINavigationController *)KEY_WINDOW.rootViewController;
            [nagVC pushViewController:subtotalVC animated:YES];
        }
         break;
        case 10:
        {
            //已下单
            LXBDidOrderViewController *didOrderVC = [[LXBDidOrderViewController alloc] init];
			_didOrderVC = didOrderVC;
            didOrderVC.dataArr = _dataArr;
            UINavigationController *nagVC = (UINavigationController *)KEY_WINDOW.rootViewController;
            [nagVC pushViewController:didOrderVC animated:YES];
        }
            break;
        case 11:{
            NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@""];
            [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
            [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
            NSString *alertMessage = [NSString stringWithFormat:@"请输入用餐人数(%@人用餐最佳)",_mealCount];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:buttonTitle forKey:@"attributedTitle"];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入用餐人数";
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *nameTf = alertController.textFields.firstObject;
                BFLog(@"请输入用餐人数====%@", nameTf.text);
                [alertController dismissViewControllerAnimated:YES completion:nil];
                if (nameTf.text.length<1) {
                    return ;
                }
                [[BFOrderServices alloc] changeOrderInfoWithOrderId:listModel.order_id dinnerNumber:nameTf.text SuccessBlock:^(id result) {
                    [BFUtils showAlertController:0 title:@"" message:@"用餐人数修改成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:updateWaiterDeskNotification object:nil];
                    [self reloadNewData];
                    self.LxbVc.mealNumber = nameTf.text;
                    [self.LxbVc refleshTitle];
                } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];
                } Failure:^(NSError *error) {
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                    
                }];
                [alertController dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            
            [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
            [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self.LxbVc presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 12:
        {
            if (![deskModel.isPay boolValue]) {
                [BFUtils showAlertController:0 title:@"" message:@"未支付的餐桌不能清台"];
                return ;
            }
            NSMutableAttributedString *buttonTitle = [[NSMutableAttributedString alloc] initWithString:@""];
            [buttonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BF_FONTSIZE_a2] range:NSMakeRange(0, [[buttonTitle string] length])];
            [buttonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[buttonTitle string] length])];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认清台" preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:buttonTitle forKey:@"attributedTitle"];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                [[BFShopServices alloc] deskClearWtihDeskId:deskModel.deskId SuccessBlock:^(id result) {
                    UIAlertController * alert = [BFUtils alertController:nil message:@"清台成功"];
                    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        UINavigationController *nagVC = (UINavigationController *)KEY_WINDOW.rootViewController;
                        [nagVC popToRootViewControllerAnimated:YES];
                    }];
                    [alert addAction:confirm];
                    [[NSNotificationCenter defaultCenter] postNotificationName:updateWaiterDeskNotification object:nil];
                }errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                    [BFUtils showAlertController:0 title:@"" message:errorMessage];
                } Failure:^(NSError *error) {
                    [BFUtils showAlertController:0 title:@"" message:@"网络错误"];
                    
                }];
                [alertController dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            
            [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
            [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self.LxbVc presentViewController:alertController animated:YES completion:nil];
        }
            
            break;
        case 13:
            [[BFOrderServices alloc] reminderMenuWithTableNum:deskModel.name printIp:[BFUserSignelton shareBFUserSignelton].printer_addr  SuccessBlock:^(id result) {
                [BFUtils showAlertController:0 title:@"" message:@"催菜成功"];
            } errorCode:^(NSInteger errorCode, NSString *errorMessage) {
                
            } Failure:^(NSError *error) {
                
            }];

            break;
        case 14:
            //消费小计
        {
            LXBsubtotalViewController *subtotalVC = [[LXBsubtotalViewController alloc] init];
            subtotalVC.messageDic = self.messageDic;
            subtotalVC.dataArr = self.dataArr;
            subtotalVC.orderIds = self.orderIds;
            UINavigationController *nagVC = (UINavigationController *)KEY_WINDOW.rootViewController;
            [nagVC pushViewController:subtotalVC animated:YES];
        }
            break;

        default:
            break;
    }
}

//颜色转图片 (绘画)
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LXBCancelFoodNotification" object:nil];
}

@end
