//
//  CMRequestAPI+TradeInquire.h
//  CMZC
//
//  Created by 财猫 on 16/4/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易

#import "CMRequestAPI.h"
#import "CMAccountinfo.h"


@interface CMRequestAPI (TradeInquire)

/**
 *  请求当日委托列表
 *
 *  @param page         第几页
 *  @param refreshToken 授权令牌
 */
+ (void)cm_tradeInquireFetchDayTrusetOnPage:(NSInteger)page
                                    success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                       fail:(void(^)(NSError *error))fail;


/**
 *  历史委托
 *
 *  @param page    第几页
 */
+ (void)cm_tradeInquireFetchHistoryTrusetOnPage:(NSInteger)page
                                        success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                           fail:(void(^)(NSError *error))fail;

/**
 *  持有产品
 *
 *  @param page    页码
 *  @param success
 *  @param fail
 */
+ (void)cm_tradeInquireFetchHoldProductOnPage:(NSInteger)page
                                      success:(void(^)(NSArray *dataArra,BOOL isPage))success
                                         fail:(void(^)(NSError *error))fail;

/**
 *  撤单
 *
 *  @param ordeNumber 订单号
 */
+ (void)cm_tradeinquireFetchRemoveOrderNumber:(NSInteger)ordeNumber
                                      success:(void(^)(BOOL isWin))success
                                         fail:(void(^)(NSError *error))fail;
/**
 *  可撤单列表
 *
 *  @param page    页码
 */
+ (void)cm_tradeinquireFetchRemoveListPage:(NSInteger)page
                                   success:(void(^)(NSArray *removeArr,BOOL isPage))success
                                      fail:(void(^)(NSError *error))fail;

/**
 *  卖出
 *
 *  @param name     产品名字
 *  @param code       产品代码
 *  @param orderPrice 产品价格
 *  @param volume     产品份数
 */
+ (void)cm_tradeInquireFetchSellPCode:(NSString *)code
                            orderName:(NSString *)name
                           orderPrice:(NSString *)orderPrice
                          orderVolume:(NSString *)volume
                              success:(void(^)(BOOL isWin))success
                                 fail:(void(^)(NSError *error))fail;

/**
 *  买入
 *
 *  @param code        v产品代码
 *  @param price       产品价格
 *  @param orderVolume 产品份数
 */
+ (void)cm_tradeInquireFetchBuyingPCode:(NSString *)code
                             orderPrice:(NSString *)price
                            orderVolume:(NSString *)orderVolume
                              orderName:(NSString *)name
                                success:(void(^)(BOOL isWin))success
                                   fail:(void(^)(NSError *error))fail;
/**
 *  产品详情获取
 *
 *  @param pcode     产品代码
 *  @param direction 买卖方向 1买入  2卖出
 */
+ (void)cm_tradeInquireFetchPrductPcode:(NSString *)pcode
                              direction:(NSString *)direction
                                success:(void(^)(NSArray *prductArr))success
                                   fail:(void(^)(NSError *error))fail;

/**
 *  成交列表
 *
 *  @param page    请求页数
 */
+ (void)cm_tradeInquireFetchDealOnPage:(NSInteger)page
                               success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                  fail:(void(^)(NSError *error))fail;

/**
 *  历史成交列表
 *
 *  @param page    请求页码
 */
+ (void)cm_tradeInquireFetchHistoryDealOnePage:(NSInteger)page
                                       success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                          fail:(void(^)(NSError *error))fail;
/**
 *  获取银行卡列表
 *
 *  @param success 成功
 *  @param fail    事变
 */
+ (void)cm_tradeWithdrawFetchBankBlockListSuccess:(void(^)(NSArray *bankBlockArr))success
                                             fail:(void(^)(NSError *error))fail;
/**
 *  提取现金
 *
 *  @param bankcardId 银行卡id
 *  @param couponId   优惠券id
 *  @param amount     提取金额
 *  @param vercode    短信验证码
 *  @param password   交易密码
 */
+ (void)cm_tradeWithdrawTransferExtractBankcardId:(NSInteger)bankcardId
                                         couponId:(NSInteger)couponId
                                           amount:(NSString *)amount
                                          vercode:(NSString *)vercode
                                    tradePassword:(NSString *)password
                                     provincecode:(NSString *)province
                                         citycode:(NSString *)city
                                         bankname:(NSString *)bank
                                           sccess:(void(^)(BOOL isWin))success
                                             fail:(void(^)(NSError *error))fail;
/**
 *  优惠券使用
 *
 *  @param type    类型  优惠券类型，1为喵券，2为提现劵，3为体验金
 */
+ (void)cm_tradeWithdrawFetchCouponlistListType:(NSInteger)type
                                        success:(void(^)(NSArray *listArr))success
                                           fail:(void(^)(NSError *error))fail;

/**
 *  用户账号获取
 */
+ (void)cm_tradeFetchAccountionfSuccess:(void(^)(CMAccountinfo *account))success
                                   fail:(void(^)(NSError *error))fail;

/**
 *  中签查询
 *
 *  @param page    页码
 */
+ (void)cm_tradeFetchDrawProductPage:(NSInteger)page
                             success:(void(^)(NSArray *dataArr,BOOL isPage))success
                                fail:(void(^)(NSError *error))fail;
/**
 *  企业信息查询
 *
 *  @param pcode   页码
 */
+ (void)cm_tradeFetchProductContextPcode:(NSInteger)pcode
                                 success:(void(^)(NSString *dataStr))success
                                    fail:(void(^)(NSError *error))fail;

/**
 *  获取系统支持的省份
 *
 *  @param province 省份
 *  @param fail     失败
 */
+ (void)cm_tradeFetchProvinceListSuccess:(void(^)(NSArray *provinceArr))success
                                    fail:(void(^)(NSError *error))fail;

/**
 *  获取系统所支持的城市
 *
 *  @param province 城市代码
 *  @param success  成功
 *  @param fail     失败
 */
+ (void)cm_tradeFetchCityListProvincecode:(NSString *)province
                                  success:(void(^)(NSArray *cityArr))success
                                     fail:(void(^)(NSError *error))fail;


@end
















































