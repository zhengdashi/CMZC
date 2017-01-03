//
//  CMRequestAPI+HomePage.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  首页api

#import "CMRequestAPI.h"
#import "CMAppVersion.h"

@interface CMRequestAPI (HomePage)





#pragma mark - 轮播图
/**
 *  轮播图
 */
+ (void)cm_homeFetchBannersSuccess:(void(^)(NSArray *bannersArr))success
                              fail:(void(^)(NSError *error))fail;

/**
 *  检测版本更新
 */
+ (void)cm_homeFetchPromoAppVersionSuccess:(void(^)(CMAppVersion *version))success
                                      fail:(void(^)(NSError *error))fail;

/**
 *  众筹宝
 *
 *  @return
 */
+ (void)cm_homeFetchProductFundlistPageSize:(NSInteger)page
                                    success:(void(^)(NSArray *fundlistArr))success
                                       fail:(void(^)(NSError *error))fail;
/**
 *  首页产品详情三
 *
 *  @param page    页码
 */
+ (void)cm_homeFetchProductThreePageSize:(NSInteger)page
                                 success:(void(^)(NSArray *threeArr))success
                                    fail:(void(^)(NSError *error))fail;


//*******************分析师**************************/

/**
 *  分析师列表
 *
 *  @param page    页码
 */
+ (void)cm_homePageFetchAnalystPage:(NSInteger)page
                            success:(void(^)(NSArray *analystArr,BOOL isPage))success
                               fail:(void(^)(NSError *error))fail;

/**
 *  分析师详情列表 -- 回答
 *
 *  @param analystId 分析师id
 *  @param pageIndex 页码
 */
+ (void)cm_homeFetchAnswerLsitAnalystId:(NSInteger)analystId
                              pageIndex:(NSInteger)pageIndex
                                success:(void(^)(NSArray *analystArr,BOOL isPage))success
                                   fail:(void(^)(NSError *error))fail;

/**
 *  话题回复
 *
 *  @param topicId 话题id
 *  @param content 话题内容
 */
+ (void)cm_homeFetchAnswerReplyTopicId:(NSInteger)topicId
                               content:(NSString *)content
                               success:(void(^)(NSArray *replyArr))success
                                  fail:(void(^)(NSError *error))fail;
/**
 *  分析师观点页
 *
 *  @param analystId 分析师id
 *  @param page      页码
 */
+ (void)cm_homeFetchAnswerPointAnalystId:(NSInteger)analystId
                                   pcode:(NSInteger)pcode
                               pageIndex:(NSInteger)page
                                 success:(void(^)(NSArray *pointArr,BOOL isPage))success
                                    fail:(void(^)(NSError *error))fail;



/**
 *  发布分析师问题
 *
 *  @param analystId 分析师id
 *  @param content   发布内容
 */
+ (void)cm_homePublishCreateAnalystId:(NSInteger)analystId
                              content:(NSString *)content
                              success:(void(^)(BOOL isWin))success
                                 fail:(void(^)(NSError *error))fail;


//*********************意见反馈**************/
/**
 *  意见反馈
 *
 *  @param appName app客户端的名称
 *  @param name    提交者名字
 *  @param number  电话
 *  @param content 反馈内容
 */
+ (void)cm_homeFetchFeedbackAppName:(NSString *)appName
                           userName:(NSString *)name
                        phoneNumber:(NSString *)number
                            content:(NSString *)content
                            success:(void(^)(BOOL isSucceed))success
                               fail:(void(^)(NSError *error))fail;



/**
 *   服务申请
 */

+ (void)cm_serviceApplicationProjectName:(NSString *)project
                                realName:(NSString *)real
                            contactPhone:(NSString *)contact
                                 success:(void(^)(BOOL isSuccess))success
                                    fail:(void(^)(NSError *error))fail;


@end






















