//
//  CMRequestAPI+Product.h
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购

#import "CMRequestAPI.h"


@class CMProductDetails;
@interface CMRequestAPI (Product)
/**
 *  获得申购列表数据
 *
 *  @param page    页码
 *  @param size
 */
+ (void)cm_applyFetchProductListOnPageIndex:(NSInteger)page
                                   pageSize:(NSInteger)size
                                    success:(void(^)(NSArray *productArr,BOOL isPage))success
                                       fail:(void(^)(NSError *error))fail;


+ (void)cm_applyFetchProductDetailsListProductId:(NSInteger)productId
                                         success:(void(^)(CMProductDetails *listArr))success
                                            fail:(void(^)(NSError *error))fail;

@end
