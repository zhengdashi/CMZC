//
//  CMRequestAPI+ProductMark.h
//  CMZC
//
//  Created by 财猫 on 16/4/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRequestAPI.h"

@interface CMRequestAPI (ProductMark)

/**
 *  行情列表
 *
 *  @param code    分类 id
 *  @param page    页码
 *  @param sort    排序字段
 */
+ (void)cm_marketFetchProductMarketCcode:(NSString *)code
                                sizePage:(NSInteger)page
                                 sorting:(NSString *)sort
                                 success:(void(^)(NSArray *marketArr,BOOL isPage))success
                                    fail:(void(^)(NSError *error))fail;


/**
 *  自选产品列表
 *
 *  @param page    页码
 */
+ (void)cm_marketFetchCollectOnPage:(NSInteger)page
                            success:(void(^)(NSArray *collectArr,BOOL isPage))success
                               fail:(void(^)(NSError *error))fail;
/**
 *  添加自选
 *
 *  @param code    产品编码
 */
+ (void)cm_marketTransferAddCode:(NSString *)code
                         success:(void(^)(BOOL isWin))success
                            fail:(void(^)(NSError *error))fail;
/**
 *  删除自选
 *
 *  @param code    编码
 */
+ (void)cm_marketTransferDeleteCode:(NSString *)code
                            success:(void(^)(BOOL isWin))success
                               fail:(void(^)(NSError *error))fail;
/**
 *  产品行情明细价格
 *
 *  @param code    产品编码
 */
+ (void)cm_marketTransferProductCode:(NSString *)code
                             success:(void(^)(NSArray *productArr))success
                                fail:(void(^)(NSError *error))fail;
/**
 *  产品行情五档盘口
 *
 *  @param code    产品编码
 */
+ (void)cm_marketTransferProductFive:(NSString *)code
                             success:(void(^)(NSArray *fiveArr))success
                                fail:(void(^)(NSError *error))fail;
/**
 *  产品行情成交明细
 *
 *  @param code    产品编码
 */
+ (void)cm_marketTransferContractDetail:(NSString *)code
                                success:(void(^)(NSArray *contractArr))success
                                   fail:(void(^)(NSError *error))fail;
/**
 *  产品行情分时行情
 *
 *  @param code    产品编码
 *  @param time    上一次请求数据的时间
 */
+ (void)cm_marketTransferMinutePcode:(NSString *)code
                            deteTime:(NSString *)time
                             success:(void(^)(NSArray *timeArr))success
                                fail:(void(^)(NSError *error))fail;
/**
 *  产品行情
 */
+ (void)cm_marketFetchProductTypeSuccess:(void(^)(NSArray *typeArr))success
                                    fail:(void(^)(NSError *error))fail;
/**
 *  日K
 *
 *  @param code    产品代码
 */
+ (void)cm_marketFetchProductKlineDayCode:(NSString *)code
                               productUrl:(NSString *)url
                                  success:(void(^)(NSArray *klineDayArr))success
                                     fail:(void(^)(NSError *error))fail;

/**
 产品明细

 @param pCode 产品编码
 @param success
 @param fail
 */
+ (void)cm_marketFetchProductinfoPcode:(NSString *)pCode
                               success:(void(^)(NSArray *productArr))success
                                  fail:(void(^)(NSError *error))fail;


/**
 *  评论信息
 *
 *  @param pCode   pCode
 *  @param page    页码
 */
+ (void)cm_marketFetchProductCommentPCode:(NSString *)pCode
                                pageIndex:(NSInteger)page
                                  success:(void(^)(NSArray *comArr))success
                                     fail:(void(^)(NSError *error))fail;
/**
 *  公告
 *
 *  @param pCode   参数
 *  @param page    页码
 */
+ (void)cm_marketFetchProductNoticePCode:(NSString *)pCode
                               pageIndex:(NSInteger)page
                                 success:(void(^)(NSArray *noticeArr))success
                                    fail:(void(^)(NSError *error))fail;



/**
 获取话题列表

 @param pcode 产品code
 @param success
 @param fail
 */
+ (void)cm_marketFetchTopicPcode:(NSString *)pcode
                       pageIndex:(NSInteger)page
                         success:(void(^)(NSArray *topicArr))success
                            fail:(void(^)(NSError *error))fail;


/**
 回复话题列表

 @param topicId 话题id
 @param page 页码
 @param success
 @param fail
 */
+ (void)cm_marketFetchReplyTopicid:(NSString *)topicId
                         pageIndex:(NSInteger)page
                           success:(void(^)(NSArray *topicArr))success
                              fail:(void(^)(NSError *error))fail;

/**
 发布话题

 @param topicId 产品id
 @param content 内容
 @param success
 @param fail
 */
+ (void)cm_marketFetchCreateProductPcode:(NSString *)pcode
                                   content:(NSString *)content
                                   success:(void(^)(BOOL isWin))success
                                      fail:(void(^)(NSError *error))fail;


/**
 回复接口

 @param topicId 话题id
 @param content 回复内容
 @param success
 @param fail
 */
+ (void)cm_marketFetchReplyCreateTopicId:(NSString *)topicId
                                 content:(NSString *)content
                                 success:(void(^)(BOOL isWin))success
                                    fail:(void(^)(NSError *error))fail;


@end






























