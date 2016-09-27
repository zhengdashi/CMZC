//
//  CMRequestAPI+Trends.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRequestAPI+Trends.h"
#import "CMMediaNews.h"
#import "CMNoticeModel.h"

@implementation CMRequestAPI (Trends)

//媒体报道
+ (void)cm_trendsFetchMediaCoverDataPage:(NSInteger)page pageSize:(NSInteger)size success:(void (^)(NSArray *,BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page),
                                @"pagesize":CMNumberWithFormat(size)
                                };

    [CMRequestAPI postDataFromURLScheme:kCMTrendsMediaCoverURL argumentsDictionary:arguments success:^(id responseObject) {
        NSArray *newsArr = responseObject[@"data"][@"rows"];
        NSMutableArray *mediaArr = [NSMutableArray array];
        for (NSDictionary *dict in newsArr) {
            CMMediaNews *mediaNews = [CMMediaNews yy_modelWithDictionary:dict];
            [mediaArr addObject:mediaNews];
        }
        NSInteger total = page * 10;
        BOOL isPage = NO;
        if (total > [responseObject[@"page"] integerValue]) {
            isPage = YES;
        }
        
        success(mediaArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//公告
+ (void)cm_trendsFetchNoticeDataPage:(NSInteger)page success:(void (^)(NSArray *,BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page),
                               // @"pagesize":CMNumberWithFormat()
                                };
    [CMRequestAPI postDataFromURLScheme:kCMTrendsNoticeURL argumentsDictionary:arguments success:^(id responseObject) {
        NSArray *noticeArr = responseObject[@"data"][@"rows"];
        NSMutableArray *noticeModeArr = [NSMutableArray array];
        for (NSDictionary *dict in noticeArr) {
            CMNoticeModel *not = [CMNoticeModel yy_modelWithDictionary:dict];
            [noticeModeArr addObject:not];
        }
        NSInteger total = page * 10;
        BOOL isPage = NO;
        if (total > [responseObject[@"total"] integerValue]) {
            isPage = YES;
        }
        success(noticeModeArr,isPage);
        
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

@end
