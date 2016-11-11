//
//  CMNetWorkConstants.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  网络请求二级地址



/**
 *  baseURL
 */
extern NSString *const kCMBase_URL;

/**
 *  websocket
 */
extern NSString *const kWebSocket_url;

/**
 *  M站地址 http://mz.58cm.com/
 */
extern NSString *const kCMMZWeb_url;

/**
 *  默认头像地址
 */
extern NSString *const kCMDefaultHeadPortrait;
//公共请求部分
extern NSString *const kCMBaseApiURL;

/**
 *  短信验证码
 */
extern NSString *const kCMShortMessageURL;


#pragma mark - 登录 注册
/**
 *  登录
 */
extern NSString *const kCMLoginURL;
/**
 *  刷新token的url
 */
extern NSString *const kCMRefreshTokenURL;
/**
 *  注册账户
 */
extern NSString *const kCMRegisterURL;
/**
 *  重置密码
 */
extern NSString *const kCMResetPasswordURL;


#pragma mark - 首页
/**
 *  首页轮播图
 */
extern NSString *const kCMHomePageBannersURL;

/**
 *  意见反馈
 */
extern NSString *const kCMHomeFeedbackURL;
/**
 *  众筹宝
 */
extern NSString *const kCMHomeFundlistURL;
/**
 *  首页产品三条数据
 */
extern NSString *const kCMHomeThreeProductURL;
/**
 *  获取版本号
 */
extern NSString *const kCMHomeAllPromoAppVersionURL;


#pragma mark - 分析师

/**
 *  分析师列表
 */
extern NSString *const kCMAnalysListURL;

/**
 *  分析师详情 -- 回答
 */
extern NSString *const kCMAnalysDetailstAnswerURL;
/**
 *  分析师详情 -- 观点
 */
extern NSString *const kCMAnalysDetailstPointURL;
/**
 *  回答 -- 回复的地址
 */
extern NSString *const kCMAnalysReplyURL;
/**
 *  发布分析师的问题
 */
extern NSString *const kCMCreateanalysttopicURL;


#pragma mark - 公告接口

/**
 *  媒体报道
 */
extern NSString *const kCMTrendsMediaCoverURL;
/**
 *  公告
 */
extern NSString *const kCMTrendsNoticeURL;



#pragma mark - 申购
/**
 *  申购列表页
 */
extern NSString *const kCMApplyListURL;
/**
 *  产品详情
 */
extern NSString *const kCMProductDetailsURL;


#pragma mark - 交易
/**
 *  当日委托
 */
extern NSString *const kCMTradeDayTrustURL;
/**
 *  历史委托
 */
extern NSString *const kCMTradeHistoryURL;
/**
 *  持有产品
 */
extern NSString *const KCMTradeHoldProduct;
/**
 *  撤单
 */
extern NSString *const kCMTradeRemoveURL;
/**
 *  可撤单列表
 */
extern NSString *const kCMTradeMayRemoveURL;
/**
 *  卖出
 */
extern NSString *const kCMTradeSaleURL;
/**
 *  买入
 */
extern NSString *const kCMTradeBuyingURL;
/**
 *  成交列表
 */
extern NSString *const kCMTradeTurnoverURL;
/**
 *  历史成交查询
 */
extern NSString *const kCMTradeHistoryTurnoverURL;

/**
 *  银行卡列表
 */
extern NSString *const kCMTradeBankBlockListURL;
/**
 *  提现
 */
extern NSString *const kCMTradeWithdrawalURL;
/**
 *  优惠券
 */
extern NSString *const kCMTradeCouponlistURL;
/**
 *  账户信息
 */
extern NSString *const kCMTradeAccountinfoURL;
/**
 *  中签查询
 */
extern NSString *const kCMTradeDrawProductNumberURL;
/**
 *  支持省份
 */
extern NSString *const kCMTradeProvinceListURL;
/**
 *  支持城市
 */
extern NSString *const kCMTradeCityListURL;

#pragma mark - 行情
/**
 *  行情头部分类信息
 */
extern NSString *const kCMProductTypelistURL;
/**
 *  行情列表
 */
extern NSString *const kCMProductMarkListURL;
/**
 *  自选列表
 */
extern NSString *const kCMTradeOptionalListURL;
/**
 *  删除自选
 */
extern NSString *const kCMOptionalDeleteURL;
/**
 *  添加自选
 */
extern NSString *const kCMOptionalAddURL;
/**
 *  买入卖出的时候请求 产品检测
 */
extern NSString *const kCMProductBuingSaleURL;
/**
 *  产品行情明细价格
 */
extern NSString *const kCMProductDetailsPriceURL;
/**
 *  产品行情五档盘口
 */
extern NSString *const kCMProductOrderFiveURL;
/**
 *  产品行情成交明细
 */
extern NSString *const kMProductContractDetailURL;
/**
 *  产品行情分时行情
 */
extern NSString *const kMProductMinuteURL;
/**
 *  日k
 */
extern NSString *const kMProductKlineDayURL;
/**
 *  周k
 */
extern NSString *const kMProductKlineWeekURL;
/**
 *  月k
 */
extern NSString *const kMProductKlineMonthURL;
/**
 *  企业信息接口
 */
extern NSString *const kMProductContextURL;//
/**
 *  行情详情评论
 */
extern NSString *const kCMProductCommentURL;
/**
 *  行情公告
 */
extern NSString *const kCMProductNoticeURL;




























