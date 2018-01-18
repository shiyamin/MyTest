//
//  LXBDidOrderTbView.h
//  01 点餐页面
//
//  Created by binbin on 2017/4/11.
//  Copyright © 2017年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alertCartDeleteDelegtae <NSObject>

- (void)clickCartDelegateAction:(NSString *)deskId;

@end

@interface LXBDidOrderTbView : UITableView

@property (nonatomic, strong) NSArray *orderDataArr;
@property (nonatomic, strong) NSArray *revokeDataArr;


@property (nonatomic, weak) id<alertCartDeleteDelegtae> aletDelegate;
@end
