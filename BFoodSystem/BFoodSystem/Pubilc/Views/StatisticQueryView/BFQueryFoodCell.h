//
//  BFQueryFoodCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/31.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFQueryFoodCellIdentifier     @"BFQueryFoodCellIdentifier"
#define BFQueryFoodCellHeight         40

@interface BFQueryFoodCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;




@property (weak, nonatomic) IBOutlet UILabel *saleNumLable;




- (void)configFoodName:(NSString *)nameStr saleNum:(NSString *)numStr;



@end
