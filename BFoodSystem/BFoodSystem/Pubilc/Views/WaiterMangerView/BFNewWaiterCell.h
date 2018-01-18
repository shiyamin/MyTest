//
//  BFNewWaiterCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/23.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeBlock)();

#define BFNewWaiterCellIdentifier   @"BFNewWaiterCellIdentifier"
#define BFNewWaiterCellHight        170

@interface BFNewWaiterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *phoneBackView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNameTf;


@property (weak, nonatomic) IBOutlet UIView *psdBackView;

@property (weak, nonatomic) IBOutlet UITextField *psdTf;


@property (weak, nonatomic) IBOutlet UIView *nameBackView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTf;


@property(nonatomic, copy) changeBlock changeBlo;

- (void)configPhoneTf:(NSString *)phoneStr psdTf:(NSString *)psdStr userNameTf:(NSString *)userStr;




@end
