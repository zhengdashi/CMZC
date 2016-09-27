//
//  CMRequestAPI+Trends.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  公告界面api

#import "CMRequestAPI.h"

@interface CMRequestAPI (Trends)

/**
 *  媒体报道请求
 *
 *  @param page    页码
 */
+ (void)cm_trendsFetchMediaCoverDataPage:(NSInteger)page
                                pageSize:(NSInteger)size
                                 success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                    fail:(void(^)(NSError *error))fail;

/**
 *  公告
 *
 *  @param page    页码
 */
+ (void)cm_trendsFetchNoticeDataPage:(NSInteger)page
                             success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                fail:(void(^)(NSError *error))fail;


@end
