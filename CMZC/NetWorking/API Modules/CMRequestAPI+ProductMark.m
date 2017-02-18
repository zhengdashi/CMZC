//
//  CMRequestAPI+ProductMark.m
//  CMZC
//
//  Created by 财猫 on 16/4/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kCMCode 800082  //测试用的

#import "CMRequestAPI+ProductMark.h"
#import "CMMarketList.h"
#import "CMModules_Header.h"
#import "CMProductType.h"
#import "CMProductComment.h"
#import "CMProductNotion.h"
#import "CMTopicList.h"
#import "CMTopicReplies.h"



@implementation CMRequestAPI (ProductMark)
//行情列表
+ (void)cm_marketFetchProductMarketCcode:(NSString *)code sizePage:(NSInteger)page sorting:(NSString *)sort success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"Ccode":code,
                           @"page":CMNumberWithFormat(page)
                           };
    [CMRequestAPI postDataFromURLScheme:kCMProductMarkListURL argumentsDictionary:dict success:^(id responseObject) {
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
        kCMTableFoot_isPage
        success(marketListArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//自选列表
+ (void)cm_marketFetchCollectOnPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"page":CMNumberWithFormat(page)
                           };
    
    [CMRequestAPI postTradeFromURLScheme:kCMTradeOptionalListURL argumentsDictionary:dict success:^(id responseObject) {
        NSString *marketStr = responseObject[@"data"][@"rows"];
        NSMutableArray *marketListArr = [NSMutableArray array];
        if (marketStr.length > 0) {
            NSArray *dataArr = [marketStr componentsSeparatedByString:@";"];
            for (NSInteger i = 0; i <dataArr.count; i ++) {
                NSString *smailStr = dataArr[i];
                NSArray *smailArr = [smailStr componentsSeparatedByString:@","];
                [marketListArr addObject:smailArr];
            }
        }
        kCMTableFoot_isPage
        success(marketListArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//添加自选
+ (void)cm_marketTransferAddCode:(NSString *)code success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"pCode":code
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMOptionalAddURL argumentsDictionary:dict success:^(id responseObject) {
        NSInteger index = [responseObject[@"data"] integerValue];
        BOOL isWin = NO;
        if (index == 1) {
            isWin = YES;
        }
        success(isWin);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//删除自选
+ (void)cm_marketTransferDeleteCode:(NSString *)code success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"PCode":code
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMOptionalDeleteURL argumentsDictionary:dict success:^(id responseObject) {
        NSInteger index = [responseObject[@"data"] integerValue];
        BOOL isWin = NO;
        if (index == 1) {
            isWin = YES;
        }
        success(isWin);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//产品编码
+ (void)cm_marketTransferProductCode:(NSString *)code success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMProductDetailsPriceURL,code];//这个地方要把参数拼接到地址后边。所以我搞不懂是否分post和get
    [CMRequestAPI postTradeFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataArrStr = responseObject[@"data"];
        NSMutableArray *prictArr = [NSMutableArray array];
        if (dataArrStr.length > 0) {
            NSArray *dataArr = [dataArrStr componentsSeparatedByString:@","];
            [prictArr addObject:dataArr];
        }
        success(prictArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//产品行情五档盘口
+ (void)cm_marketTransferProductFive:(NSString *)code success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMProductOrderFiveURL,code];
    [CMRequestAPI postOrdinaryFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
}
//产品行情成交明细
+ (void)cm_marketTransferContractDetail:(NSString *)code success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kMProductContractDetailURL,code];
    [CMRequestAPI postOrdinaryFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        NSString *rowsStr = responseObject[@"data"][@"rows"];
        if (rowsStr.length >0) {
            NSArray *prictArr = [rowsStr componentsSeparatedByString:@";"];
            NSMutableArray *contArr = [NSMutableArray array];
            for (NSString *contStr in prictArr) {
                if (contStr.length == 0) {
                    return ;
                }
                NSArray *itemArr = [contStr componentsSeparatedByString:@","];
                [contArr addObject:itemArr];
            }
            success(contArr);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

//产品行情分时行情
+ (void)cm_marketTransferMinutePcode:(NSString *)code deteTime:(NSString *)time success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kMProductMinuteURL,code,time];
    [CMRequestAPI postOrdinaryFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataStr = responseObject[@"data"];
        if (dataStr.length != 0) {
            NSArray *proctArr = [dataStr componentsSeparatedByString:@";"];
            NSMutableArray *timeArr = [NSMutableArray array];
            for (NSString *timeItemStr in proctArr) {
                NSArray *itemArr = [timeItemStr componentsSeparatedByString:@","];
                [timeArr addObject:itemArr];
            }
            success(timeArr);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//行情头部视图
+ (void)cm_marketFetchProductTypeSuccess:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    
    [CMRequestAPI postDataFromURLScheme:kCMProductTypelistURL argumentsDictionary:nil success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *contData = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMProductType *type = [CMProductType yy_modelWithDictionary:dict];
            [contData addObject:type];
        }
        success(contData);
    } fail:^(NSError *error) {
        fail(error);
    }];    
}
//日K
+ (void)cm_marketFetchProductKlineDayCode:(NSString *)code productUrl:(NSString *)url success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    //先写死。数据测试
      [CMRequestAPI getDataFromURLScheme:url argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataStr = responseObject[@"data"];
        NSArray * dataArr = [dataStr componentsSeparatedByString:@";"];
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
    
}
//产品明细
+(void)cm_marketFetchProductinfoPcode:(NSString *)pCode success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *url = CMStringWithPickFormat(kMProductInfoURL, pCode);
    [CMRequestAPI postDataFromURLScheme:url argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataStr = responseObject[@"data"];
        NSArray *dataArr = [dataStr componentsSeparatedByString:@","];
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
    
}


//评论
+ (void)cm_marketFetchProductCommentPCode:(NSString *)pCode pageIndex:(NSInteger)page success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"pCode":pCode,
                           @"pageindex":CMNumberWithFormat(page)
                           };
    
    
    
    [CMRequestAPI postDataFromURLScheme:kCMProductCommentURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *comArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMProductComment *com = [CMProductComment yy_modelWithDictionary:dict];
            [comArr addObject:com];
        }
        success(comArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//公告
+ (void)cm_marketFetchProductNoticePCode:(NSString *)pCode pageIndex:(NSInteger)page success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"pCode":pCode,
                           @"pageindex":CMNumberWithFormat(page)
                           };
    [CMRequestAPI postDataFromURLScheme:kCMProductNoticeURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *comArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMProductNotion *com = [CMProductNotion yy_modelWithDictionary:dict];
            [comArr addObject:com];
        }
        success(comArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//获取话题列表
+ (void)cm_marketFetchTopicPcode:(NSString *)pcode pageIndex:(NSInteger)page success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"pcode":pcode,
                           @"PageIndex":CMStringWithFormat(page)};
    [CMRequestAPI postDataFromURLScheme:kCMProductTopictURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *listArr = responseObject[@"data"];
        NSMutableArray *dataListArr = [NSMutableArray array];
        for (NSDictionary *dict in listArr) {
            CMTopicList *topicList = [CMTopicList yy_modelWithDictionary:dict];
            NSArray *replies = dict[@"replies"];
            NSMutableArray *repliesArr = [NSMutableArray array];
            for (NSDictionary *repDic in replies) {
                CMTopicReplies *topicReplies = [CMTopicReplies yy_modelWithDictionary:repDic];
                [repliesArr addObject:topicReplies];
            }
            topicList.repliesArr = repliesArr;
            [dataListArr addObject:topicList];
        }
        success(dataListArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//回复话题列表
+ (void)cm_marketFetchReplyTopicid:(NSString *)topicId pageIndex:(NSInteger)page success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"topicid":topicId,
                           @"PageIndex":CMStringWithFormat(page)
                           };
    [CMRequestAPI postDataFromURLScheme:kCMProductTopicReplyURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *topicArr = responseObject[@"data"];
        NSMutableArray *dataRepliesArr = [NSMutableArray array];
        for (NSDictionary *dict in topicArr) {
            CMTopicReplies *replies = [CMTopicReplies yy_modelWithDictionary:dict];
            [dataRepliesArr addObject:replies];
        }
        success(dataRepliesArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//发布话题
+ (void)cm_marketFetchCreateProductPcode:(NSString *)pcode content:(NSString *)content success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"pcode":pcode,
                           @"content":content
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMProductCreateproductTopic argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

+ (void)cm_marketFetchReplyCreateTopicId:(NSString *)topicId content:(NSString *)content success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"TopicID":topicId,
                           @"content":content
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMProductReplyCreateURL argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}


@end








































































