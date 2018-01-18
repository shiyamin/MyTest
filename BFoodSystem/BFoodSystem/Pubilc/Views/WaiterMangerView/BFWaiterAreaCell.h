//
//  BFWaiterAreaCell.h
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/24.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFWaiterAreaCellIdentifier   @"BFWaiterAreaCellIdentifier"
#define BFWaiterAreaCellHeight       200

@protocol BFWaiterAreaCellDelegate <NSObject>

- (void)getAreaIdsFromWaiterAreaCell:(NSString *)areaIds;

@end

@interface BFWaiterAreaCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *areaTitleLab;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) id <BFWaiterAreaCellDelegate> delegate;


- (void)getAreaInfoList:(NSMutableArray *)areaArr;







@end
