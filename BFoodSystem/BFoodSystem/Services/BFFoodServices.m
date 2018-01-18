//
//  BFFoodServices.m
//  BFoodSystem
//
//  Created by 陈名正 on 2017/3/28.
//  Copyright © 2017年 陈名正. All rights reserved.
//

#import "BFFoodServices.h"
#import "BFFoodClassModel.h"
#import "BFFoodModel.h"
#import "BFFoodTypeModel.h"
#import "BFFoodSaleModel.h"

@implementation BFFoodServices



/**
 删除菜品分类
 
 @param typeId 菜品分类的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectDishesTypeWithTypeId:(NSString *)typeId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSLog(@"%@-----",[BFUserSignelton shareBFUserSignelton].token);
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:typeId forKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishesType/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除菜品分类====%@", responseObject);
        
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



/**
 获取菜品分类信息
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDishesListWtihSaleStatus:(NSString *)saleType SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    //1.获取URL
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishesType/getList"];
    BFLog(@"%@", URL);
    //根据token存入相关数据
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:saleType forKey:@"is_shelf"];

    //根据URL和dic和对应的请求方法获取数据
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dataDic in [resDic objectForKey:@"data"]) {
                BFFoodClassModel *classModel = [[BFFoodClassModel alloc] init];
                classModel.dishesArr = [NSMutableArray array];
                [classModel setValuesForKeysWithDictionary:dataDic];
                for (NSDictionary *foodic in [dataDic objectForKey:@"dishes_list"]) {
                    BFFoodModel *foodModel = [[BFFoodModel alloc] init];
                    [foodModel setValuesForKeysWithDictionary:foodic];
                    [classModel.dishesArr addObject:foodModel];
                }
                [modelArr addObject:classModel];
            }
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"========%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    

}



/**
 修改或保存菜品分类信息
 
 @param nameStr 分类名称
 @param levelStr 等级
 @param dishesId 分类id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveDishesInfoWithName:(NSString *)nameStr sortLevel:(NSString *)levelStr dishesId:(NSString *)dishesId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:dishesId forKey:@"id"];
    [dic setObject:nameStr forKey:@"name"];
    [dic setObject:levelStr forKey:@"sort"];

    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishesType/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"修改区域信息====%@", responseObject);
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





/**
 删除菜品接口
 
 @param foodId 菜品的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectFoodWithFoodId:(NSString *)foodId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:foodId forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishes/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除菜品分类====%@", responseObject);
        
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



/**
 获取菜品详细信息
 
 @param foodId 菜品的id
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getFoodDetailWithFoodId:(NSString *)foodId SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{

    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishes/getDetail"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"========%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}




/**
 获取菜品列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getDishLishWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishes/getList"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dataDic in [resDic objectForKey:@"data"]) {
                BFFoodModel *foodModel = [[BFFoodModel alloc] init];
                [foodModel setValuesForKeysWithDictionary:dataDic];
                foodModel.typeArr = [NSMutableArray array];
                for (NSDictionary *typeDic in [dataDic objectForKey:@"type_list"]) {
                    BFFoodTypeModel *foodTypeMdoel  = [[BFFoodTypeModel alloc] init];
                    [foodTypeMdoel setValuesForKeysWithDictionary:typeDic];
                    [foodModel.typeArr addObject:foodTypeMdoel];
                }
                [modelArr addObject:foodModel];
            }
            success(modelArr);

        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"========%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];

}



/**
 保存修改菜品信息
 
 @param foodName 菜品名字
 @param foodDes 菜品描述
 @param foodPrice 菜品价格
 @param foodId 菜品的id
 @param typeIds 菜品分类ids
 @param picLists 菜品图片ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveFoodInfoWithFoodName:(NSString *)foodName foodDescription:(NSString *)foodDes foodPrice:(NSString *)foodPrice foodId:(NSString *)foodId typeIds:(NSString *)typeIds picLists:(NSString *)picLists SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:foodId forKey:@"id"];
    [dic setObject:foodName forKey:@"name"];
    [dic setObject:foodDes forKey:@"description"];
    [dic setObject:foodPrice forKey:@"price"];
    [dic setObject:typeIds forKey:@"type_ids"];
    [dic setObject:picLists forKey:@"pic_list"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/dishes/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除菜品分类====%@", responseObject);
        
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



/**
 批量下架菜品
 
 @param foodIds 菜品的ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)delectManyFoodWithFoodIds:(NSString *)foodIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:foodIds forKey:@"ids"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shelf/delete"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除菜品分类====%@", responseObject);
        
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



/**
 批量上架菜品
 
 @param foodIds 菜品的ids
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)saveManyFoodOnSaleWithFoodIds:(NSString *)foodIds SuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    [dic setObject:foodIds forKey:@"ids"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shelf/save"];
    BFLog(@" url=%@\n dic = %@", url, dic);
    NSMutableURLRequest *request = [BFYBaseNetTool dealRequset:url dataDic:dic];
    [BFYBaseNetTool postRequest:request params:dic success:^(id responseObject, NSURLResponse *response) {
        BFLog(@"删除菜品分类====%@", responseObject);
        
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



/**
 获取上架菜品列表
 
 @param success 成功回调
 @param errCode 错误信息回调
 @param failure 失败回调
 */
- (void)getOnSaleListWithSuccessBlock:(RequestSuccessBlock)success errorCode:(RequestErrorCodeBlock)errCode Failure:(RequestFailureBlock)failure{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseURL,@"/shelf/getList"];
    BFLog(@"%@", URL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[BFUserSignelton shareBFUserSignelton].token forKey:@"token"];
    
    [BFYBaseNetTool getRequest:URL requestDic:dic success:^(id responseObject, NSURLResponse *response) {
        NSDictionary *resDic = (NSDictionary *)responseObject;
        if ([[resDic objectForKey:@"code"] integerValue] == 0) {
            NSMutableArray *modelArr = [NSMutableArray array];
            for (NSDictionary *dataDic in [resDic objectForKey:@"data"]) {
                BFFoodClassModel *classModel = [[BFFoodClassModel alloc] init];
                [classModel setValuesForKeysWithDictionary:dataDic];
                classModel.dishesArr = [NSMutableArray array];
                for (NSDictionary *disDic in [dataDic objectForKey:@"shelf_list"]) {
                    BFFoodSaleModel *foodSaleModel = [[BFFoodSaleModel alloc] init];
                    [foodSaleModel setValuesForKeysWithDictionary:disDic];
                    [classModel.dishesArr addObject:foodSaleModel];
                }
                [modelArr addObject:classModel];
            }
            success(modelArr);
        }else{
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            NSString *errorMsg = [resDic objectForKey:@"msg"];
            errCode(code,errorMsg);
        }
        BFLog(@"========%@", responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
}





@end
