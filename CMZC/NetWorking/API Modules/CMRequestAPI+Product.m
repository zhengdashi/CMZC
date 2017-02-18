//
//  CMRequestAPI+Product.m
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRequestAPI+Product.h"
#import "CMProductList.h"
#import "CMPurchaseProduct.h"
#import "CMProductDetails.h"


@implementation CMRequestAPI (Product)

+ (void)cm_applyFetchProductListOnPageIndex:(NSInteger)page pageSize:(NSInteger)size success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"pageindex":CMNumberWithFormat(page),
                           @"pagesize":CMNumberWithFormat(size)
                           };
    
    [CMRequestAPI postDataFromURLScheme:kCMApplyListURL argumentsDictionary:dict success:^(id responseObject) {
        
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *analysArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMPurchaseProduct *analys = [CMPurchaseProduct yy_modelWithDictionary:dict];
            [analysArr addObject:analys];
        }
        
        BOOL isPage = NO;
        if (page < [responseObject[@"data"][@"page"] integerValue]) {
            isPage = YES;
        }
        success(analysArr,isPage);
        
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

+ (void)cm_applyFetchProductDetailsListProductId:(NSInteger)productId success:(void (^)(CMProductDetails *))success fail:(void (^)(NSError *))fail {
    
    NSDictionary *dict = @{@"productId":CMNumberWithFormat(productId)};
    
    NSString *str = [NSString stringWithFormat:@"%@/%ld",kCMProductDetailsURL,(long)productId];
    [CMRequestAPI postDataFromURLScheme:str argumentsDictionary:dict success:^(id responseObject) {
        CMProductDetails *details ;
        if ([responseObject[@"errcode"] integerValue] == 0) {
            NSDictionary *dict = responseObject[@"data"];
            details = [CMProductDetails yy_modelWithJSON:dict];
        }
        success(details);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

@end





































