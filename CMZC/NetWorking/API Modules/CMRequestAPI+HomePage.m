////
//  CMRequestAPI+HomePage.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRequestAPI+HomePage.h"
#import "CMBanners.h"
#import "CMAnalystMode.h"
#import "CMAnalystAnswer.h"
#import "CMAnalystPoint.h"
#import "CMNumberous.h"


@implementation CMRequestAPI (HomePage)

//轮播图
+ (void)cm_homeFetchBannersSuccess:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI postDataFromURLScheme:kCMHomePageBannersURL argumentsDictionary:nil success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *transArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMBanners *bans = [CMBanners yy_modelWithDictionary:dict];
            [transArr addObject:bans];
        }
        success(transArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//检测版本更新
+ (void)cm_homeFetchPromoAppVersionSuccess:(void (^)(CMAppVersion *))success fail:(void (^)(NSError *))fail {
    NSString *kUrlStr = [NSString stringWithFormat:@"%@%@",kCMHomeAllPromoAppVersionURL,@"0"];
    [CMRequestAPI postDataFromURLScheme:kUrlStr argumentsDictionary:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        CMAppVersion *version = [CMAppVersion yy_modelWithDictionary:dict];
        success(version);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}


//众筹宝
+ (void)cm_homeFetchProductFundlistPageSize:(NSInteger)page success:(void(^)(NSArray *fundlistArr))success fail:(void(^)(NSError *error))fail {
    NSDictionary *dict = @{
                           @"pagesize":CMNumberWithFormat(page)
                           };
    [CMRequestAPI postDataFromURLScheme:kCMHomeFundlistURL argumentsDictionary:dict success:^(id responseObject) {
        
        NSArray *contArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dic in contArr) {
            CMNumberous *numberous = [CMNumberous yy_modelWithDictionary:dic];
            [dataArr addObject:numberous];
        }
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
    
}
//首页三个产品
+ (void)cm_homeFetchProductThreePageSize:(NSInteger)page success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    
    [CMRequestAPI postTradeFromURLScheme:kCMHomeThreeProductURL argumentsDictionary:nil success:^(id responseObject) {
        NSString *marketStr = responseObject[@"data"][@"rows"];
        NSMutableArray *marketListArr = [NSMutableArray array];
        if (marketStr.length >0) {
            NSArray *dataArr = [marketStr componentsSeparatedByString:@";"];
            for (NSInteger i = 0; i <dataArr.count; i ++) {
                NSString *smailStr = dataArr[i];
                NSArray *smailArr = [smailStr componentsSeparatedByString:@","];
                [marketListArr addObject:smailArr];
            }
            
        }
        success(marketListArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
    
}


//分析师
+ (void)cm_homePageFetchAnalystPage:(NSInteger)page success:(void (^)(NSArray *,BOOL ))success fail:(void (^)(NSError *))fail {
    NSDictionary *arguments = @{@"pageindex":CMNumberWithFormat(page)};
    
    
    [CMRequestAPI postDataFromURLScheme:kCMAnalysListURL argumentsDictionary:arguments success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *analysArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMAnalystMode *analys = [CMAnalystMode yy_modelWithDictionary:dict];
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
//回答
+ (void)cm_homeFetchAnswerLsitAnalystId:(NSInteger)analystId pageIndex:(NSInteger)pageIndex success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"analystid":CMNumberWithFormat(analystId),
                           @"pageindex":CMNumberWithFormat(pageIndex)
                           };
    //因为没有数据，先注销掉
    
    [CMRequestAPI postDataFromURLScheme:kCMAnalysDetailstAnswerURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *listData = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMAnalystAnswer *details = [CMAnalystAnswer yy_modelWithDictionary:dict];
            
            NSMutableArray *repliesArr = [NSMutableArray array];
            NSArray *repArr = dict[@"replies"];
            for (NSDictionary *dict in repArr) {
                CMAnalystViewpoint *listData = [CMAnalystViewpoint yy_modelWithDictionary:dict];
                [repliesArr addObject:listData];
                details.repliseArr = repliesArr;
            }
            [listData addObject:details];
        }
        
        BOOL isPage = NO;
        if (pageIndex < [responseObject[@"data"][@"page"] integerValue]) {
            isPage = YES;
        }
        success(listData,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//回复分析师的问题
+ (void)cm_homeFetchAnswerReplyTopicId:(NSInteger)topicId content:(NSString *)content success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"topicid":CMNumberWithFormat(topicId),
                           @"content":content
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMAnalysReplyURL argumentsDictionary:dict success:^(id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSDictionary *dict = responseObject[@"data"];
        CMAnalystViewpoint *listData = [CMAnalystViewpoint yy_modelWithDictionary:dict];
        [dataArr addObject:listData];
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//发布问题
+ (void)cm_homePublishCreateAnalystId:(NSInteger)analystId content:(NSString *)content success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"analystid":CMNumberWithFormat(analystId),
                           @"content":content
                           };
    
    [CMRequestAPI postTradeFromURLScheme:kCMCreateanalysttopicURL argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}


//意见反馈
+ (void)cm_homeFetchFeedbackAppName:(NSString *)appName userName:(NSString *)name phoneNumber:(NSString *)number content:(NSString *)content success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"appname":appName,
                           @"name":name,
                           @"phonenumber":number,
                           @"content":content
                           };
    [CMRequestAPI postDataFromURLScheme:kCMHomeFeedbackURL argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//分析师观点页
+ (void)cm_homeFetchAnswerPointAnalystId:(NSInteger)analystId pcode:(NSInteger)pcode pageIndex:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict;
    if (pcode == 0) {
        dict = @{
                 @"analystid":CMNumberWithFormat(analystId),
                 @"pageindex":CMNumberWithFormat(page)
                 };
    } else {
        dict = @{
                 @"pcode":CMNumberWithFormat(pcode),
                 @"pageindex":CMNumberWithFormat(page)
                 };
    }
    
    
    [CMRequestAPI postDataFromURLScheme:kCMAnalysDetailstPointURL argumentsDictionary:dict success:^(id responseObject) {
        NSMutableArray *pointArr = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"rows"]) {
            CMAnalystPoint *point = [CMAnalystPoint yy_modelWithDictionary:dict];
            [pointArr addObject:point];
        }
        BOOL isPage = NO;
        if (page < [responseObject[@"page"][@"rows"] integerValue]) {
            isPage = YES;
        }
        success(pointArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//服务申请
+ (void)cm_serviceApplicationProjectName:(NSString *)project realName:(NSString *)real contactPhone:(NSString *)contact success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                         @"TrueName":project,
                         @"ProjectName":real,
                         @"Tel":contact
                         };
    [CMRequestAPI postDataFromURLScheme:kCMHomeCreateroubleinfoURL argumentsDictionary:dict success:^(id responseObject) {
        BOOL isSucess = NO;
        if ([responseObject[@"errcode"] integerValue] == 0) {
            isSucess = YES;
        }
        success(isSucess);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

+ (void)cm_homeDefaultPageGlodServiceSuccess:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI postDataFromURLScheme:kCMHomeAnalystDefaultURL argumentsDictionary:nil success:^(id responseObject) {
        NSMutableArray *adminArr = [NSMutableArray array];
        NSArray *dataRow = responseObject[@"data"][@"row"];
        for (NSDictionary *dict in dataRow) {
            CMAdministrator *admin = [CMAdministrator yy_modelWithDictionary:dict];
            [adminArr addObject:admin];
        }
        success(adminArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//理财师详情
+ (void)cm_homeAnalystDetailsAnalystsId:(NSInteger)analystsId success:(void (^)(CMAnalystMode *))success fail:(void (^)(NSError *))fail {
    
   
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",KCMAnalystsDetailsURL,CMStringWithFormat(analystsId)];
    
    [CMRequestAPI postOrdinaryFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        CMAnalystMode *analyst = [CMAnalystMode yy_modelWithJSON:responseObject[@"data"]];
        success(analyst);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
    
}

+ (void)cm_homeProductPurchaseNumberSuccess:(void (^)(NSString *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI getDataFromURLScheme:kCMHomePurchaseNumberURL argumentsDictionary:nil success:^(id responseObject) {
        success(responseObject[@"data"]);
    } fail:^(NSError *error) {
        fail(error);
    }];
}



@end


























