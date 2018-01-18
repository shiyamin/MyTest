//
//  BFDeskAreaServices.m
//  BFoodSystem
//
//  Created by xiangmeng on 2017/4/7.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFDeskAreaServices.h"
#import "BFAreaModel.h"
#import "BFDeskModel.h"
#import "BFWaiterList.h"
#import "LXBOrder_listModel.h"
#import "LXBCookingdetailModel.h"
#import <AFNetworking/AFNetworking.h>
@implementation BFDeskAreaServices

//获取桌子区域类所有的桌子信息
- (void)getDeskAreaWtihSaleStatus:(NSString *)saleType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/deskArea/getList"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSArray *dataArr = [resDic objectForKey:@"data"];
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                BFAreaModel *model = [[BFAreaModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSMutableArray *deskArr = [NSMutableArray array];
                for (NSDictionary *dic in model.desk_list) {
                    BFDeskModel *deskModel = [[BFDeskModel alloc] init];
                    [deskModel setValuesForKeysWithDictionary:dic];
                    NSMutableArray *areaArr = [NSMutableArray array];
                    for (NSDictionary *dic in deskModel.area) {
                        BFAreaModel *areaModel = [[BFAreaModel alloc] init];
                        [areaModel setValuesForKeysWithDictionary:dic];
                        [areaArr addObject:areaModel];
                    }
                    NSMutableArray *orderArr = [NSMutableArray array];
                    for (NSDictionary *dic in deskModel.order_list) {
                        LXBOrder_listModel *orderModel = [[LXBOrder_listModel alloc] init];
                        [orderModel setValuesForKeysWithDictionary:dic];
                        NSMutableArray *dishesArr = [NSMutableArray array];
                        for (NSDictionary *dic in orderModel.dishes_list) {
                            LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                            [dishesModel setValuesForKeysWithDictionary:dic];
                            [dishesArr addObject:dishesModel];
                        }
                        NSMutableArray *cancelArr = [NSMutableArray array];
                        for (NSDictionary *dic in orderModel.cancel_list) {
                            LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                            [dishesModel setValuesForKeysWithDictionary:dic];
                            [cancelArr addObject:dishesModel];
                        }
                        orderModel.dishes_list = dishesArr;
                        orderModel.cancel_list = cancelArr;
                        [orderArr addObject:orderModel];
                    }
                    deskModel.area = areaArr;
                    deskModel.order_list = orderArr;
                    [deskArr addObject:deskModel];
                }
                NSMutableArray *waiterArr = [NSMutableArray array];
                for (NSDictionary *dic in model.waiter_list) {
                    BFWaiterList *waiterModel = [[BFWaiterList alloc] init];
                    [waiterModel setValuesForKeysWithDictionary:dic];
                    [waiterArr addObject:waiterModel];
                }
                model.desk_list = deskArr;
                model.waiter_list = waiterArr;
                [modelArr addObject:model];
            }
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"区域桌子信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
    
    }];
    
    
}

//获取桌子详情信息,菜品的订单
- (void)getDeskDetailWithDeskId:(NSString *)deskId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure
{
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/desk/getDetail"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:deskId forKey:@"id"];
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dataDic = [resDic objectForKey:@"data"];
            NSMutableArray *modelArr = [NSMutableArray array];
                BFDeskModel *deskModel = [[BFDeskModel alloc] init];
                [deskModel setValuesForKeysWithDictionary:dataDic];
                NSMutableArray *orderArr = [NSMutableArray array];
                for (NSDictionary *dic in deskModel.order_list) {
                    LXBOrder_listModel *orderModel = [[LXBOrder_listModel alloc] init];
                    [orderModel setValuesForKeysWithDictionary:dic];
                    NSMutableArray *dishesArr = [NSMutableArray array];
                    for (NSDictionary *dic in orderModel.dishes_list) {
                        LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                        [dishesModel setValuesForKeysWithDictionary:dic];
                        [dishesArr addObject:dishesModel];
                    }
                    NSMutableArray *cancelArr = [NSMutableArray array];
                    for (NSDictionary *dic in orderModel.cancel_list) {
                        LXBCookingdetailModel *dishesModel = [[LXBCookingdetailModel alloc] init];
                        [dishesModel setValuesForKeysWithDictionary:dic];
                        [cancelArr addObject:dishesModel];
                    }
                    orderModel.dishes_list = dishesArr;
                    orderModel.cancel_list = cancelArr;
                    [orderArr addObject:orderModel];
                }
                deskModel.order_list = orderArr;
                [modelArr addObject:deskModel];
        
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"餐桌详情信息===%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}

- (void)revokedDishesReportWithParameter:(NSDictionary *)parameter SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
	
	NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/order/cancel"];
	
	 NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:[parameter mutableCopy]];
	[BFYBaseNetTool postRequest:request params:[parameter mutableCopy] success:^(id responseObject, NSURLResponse *response) {
		BFLog(@"撤销菜品====%@", responseObject);
		
		NSDictionary *dataDic = (NSDictionary *)responseObject;
		if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
			success(@"YES");
		}else{
			NSInteger code = [[dataDic objectForKey:@"code"] integerValue];
			NSString *errorMsg = [dataDic objectForKey:@"msg"];
			errCode(code,errorMsg);
		}
		
	} failure:^(NSError *error) {
		failure(error);
	}];

	
}

@end
