//
//  CMNetWorkConstants.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//



//#define kCM_URL @"http://192.168.1.15:8384/"
#define kCM_URL @"http://zcapi.xinjingban.com:80/" //线上地址
//#define kCM_URL @"http://192.168.1.49:9000/"
NSString *const kCMBase_URL = @"http://zcapi.xinjingban.com:80/"; //线上
//NSString *const kCMBase_URL = @"http://192.168.1.49:9000/";
//websocket
NSString *const kWebSocket_url = @"ws://zcapi.xinjingban.com:80/";//线上



// m站地址
//NSString *const kCMMZWeb_url = @"http://mz.58cm.com/";
//新的地址 m站地址
NSString *const kCMMZWeb_url = @"http://m.xinjingban.com/";
//NSString *const kCMMZWeb_url = @"http://192.168.1.49:7080/"; //吼
//NSString *const kCMMZWeb_url = @"http://192.168.1.225:8886/";
NSString *const kCMDefaultHeadPortrait = @"tupian.jpg";

// 线上地址 http://zcapi.xinjingban.com
//公共请求部分 //本店环境 http://192.168.1.12:9000/  //线上环境 http://zcapi.58cm.com/
NSString *const kCMBaseApiURL = kCM_URL;
//获取短信验证码
NSString *const kCMShortMessageURL = @"/api/message/sendsmsvercode";
//三条产品数据
NSString *const kCMHomeThreeProductURL = @"/api/market/top";
#pragma mark - 登录 注册
//注册
NSString *const kCMRegisterURL = @"/api/user/register";
//重置
NSString *const kCMResetPasswordURL = @"/api/user/resetpassword";
//登录
NSString *const kCMLoginURL = @"/token";
//刷新token
NSString *const kCMRefreshTokenURL = @"/token";
#pragma mark - 首页
//首页轮播图
NSString *const kCMHomePageBannersURL = @"/api/promo/banners";
//意见反馈
NSString *const kCMHomeFeedbackURL = @"/api/promo/feedback";
//众筹宝
NSString *const kCMHomeFundlistURL = @"api/product/fundlist";

#pragma mark - 分析师
//分析师
NSString *const kCMAnalysListURL = @"/api/analyst/list";
//分析师详情 -- 回答
NSString *const kCMAnalysDetailstAnswerURL = @"/api/topic/analysttopics";
//   观点
NSString *const kCMAnalysDetailstPointURL = @"/api/analyst/standpointlist";
//回复的地址
NSString *const kCMAnalysReplyURL = @"/api/reply/create";
//发布分析师问题
NSString *const kCMCreateanalysttopicURL = @"/api/topic/createanalysttopic";

NSString *const kCMHomeAllPromoAppVersionURL = @"/api/promo/AppVersion?pt=";

#pragma mark - 公告接口
// 媒体报道
NSString *const kCMTrendsMediaCoverURL = @"/api/news/medianews";
// 公告
NSString *const kCMTrendsNoticeURL = @"/api/news/notices";
#pragma mark - 申购
NSString *const kCMApplyListURL = @"/api/product/list";
//产品详情
NSString *const kCMProductDetailsURL = @"/api/product";


#pragma mark - 交易
//当日委托
NSString *const kCMTradeDayTrustURL = @"/api/order";
//历史委托
NSString *const kCMTradeHistoryURL = @"/api/order/bak";
//持有产品
NSString *const KCMTradeHoldProduct = @"/api/market/hold";
//撤单
NSString *const kCMTradeRemoveURL = @"/api/market/cancel";
//可撤单列表
NSString *const kCMTradeMayRemoveURL = @"/api/order/cancel";
//卖出
NSString *const kCMTradeSaleURL = @"/api/market/sale";
//买入
NSString *const kCMTradeBuyingURL = @"/api/market/buy";
//成交列表
NSString *const kCMTradeTurnoverURL = @"/api/contract";
//历史成交查询
NSString *const kCMTradeHistoryTurnoverURL = @"/api/contract/bak";
//银行卡列表
NSString *const kCMTradeBankBlockListURL = @"/api/user/bankcardlist";
//提现
NSString *const kCMTradeWithdrawalURL = @"/api/user/withdrawrequest";
//优惠券
NSString *const kCMTradeCouponlistURL = @"/api/user/couponlist";
//账户信息
NSString *const kCMTradeAccountinfoURL = @"/api/user/accountinfo";
//中签查询
NSString *const kCMTradeDrawProductNumberURL = @"/api/product/number";
//支持省份
NSString *const kCMTradeProvinceListURL = @"/api/province/list";
//支持的城市
NSString *const kCMTradeCityListURL = @"/api/city/list";

#pragma mark - 行情
//行情头部分类信息
NSString *const kCMProductTypelistURL = @"/api/product/typelist";
//行情列表
NSString *const kCMProductMarkListURL = @"/api/market/product";
//自选列表
NSString *const kCMTradeOptionalListURL = @"api/collect/list";
//删除自选
NSString *const kCMOptionalDeleteURL = @"api/collect/Delete";
//添加自选
NSString *const kCMOptionalAddURL = @"api/collect/add";
//产品检测
NSString *const kCMProductBuingSaleURL = @"api/market/product";
//产品行情明细价格
NSString *const kCMProductDetailsPriceURL = @"api/market/product/";
//产品行情五档盘口
NSString *const kCMProductOrderFiveURL = @"api/order/five/";
//产品行情成交明细
NSString *const kMProductContractDetailURL = @"api/contract/detail/";
//行情分时行情
NSString *const kMProductMinuteURL = @"api/minute/market/";
//日k
NSString *const kMProductKlineDayURL = @"api/kline/day/";
//周k
NSString *const kMProductKlineWeekURL = @"api/kline/week/";
//月k
NSString *const kMProductKlineMonthURL = @"api/kline/month/";
//企业信息接口
NSString *const kMProductContextURL = @"api/product/context/";
//评论
NSString *const kCMProductCommentURL = @"/api/topic/producttopics";
//公告
NSString *const kCMProductNoticeURL = @"/api/news/productnews";












