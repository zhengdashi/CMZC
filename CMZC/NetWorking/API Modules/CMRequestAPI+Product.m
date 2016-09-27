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

@implementation CMRequestAPI (Product)

+ (void)cm_applyFetchProductListOnPageIndex:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"pageindex":CMNumberWithFormat(page)};
    
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

@end
