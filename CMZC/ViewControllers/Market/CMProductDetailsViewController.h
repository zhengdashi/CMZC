//
//  CMProductDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  产品详情cell

#import "CMBaseViewController.h"

typedef NS_ENUM(NSInteger,CMProductSelectType) {
    CMProductSelecttypeAnalystsDiagnosis, //分析师诊断
    CMProductSelectTypeComments, //评论 行情吧
    CMProductSelectTypeNounce, //公告 信息披露
    CMProductSelectTypeEnterprise, //公司概况
    CMProductSelectTypeProductAndMarket, //产品与市场
    CMProductSelectTypeFinancialIndicators,  //财务指标
    CMProductSelectTypeTeamEquity, //团队与股权
    CMProductSelectTypeDetails //产品详情
};

@interface CMProductDetailsViewController : CMBaseViewController
@property (nonatomic,copy) NSString *productId;//行情id

@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,copy) NSString *codeName;

@property (nonatomic,assign) CMProductSelectType type;

@end
