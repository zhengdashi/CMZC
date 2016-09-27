//
//  CMRequestAPI+TradeInquire.m
//  CMZC
//
//  Created by 财猫 on 16/4/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kCMDict_page NSDictionary *dict = @{@"page":CMNumberWithFormat(page)};

#import "CMRequestAPI+TradeInquire.h"
#import "CMTradeDayAuthorize.h"
#import "CMTurnoverList.h"
#import "CMModules_Header.h"
#import "CMBankBlockList.h"
#import "CMHoldInquire.h"
#import "CMWinning.h"
#import "CMMayRemove.h"
#import "CMProvinceList.h"



@implementation CMRequestAPI (TradeInquire)
//当日委托
+ (void)cm_tradeInquireFetchDayTrusetOnPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
   //kCMDict_page
    NSDictionary *dict = @{@"page":CMNumberWithFormat(page)};
    [CMRequestAPI postTradeFromURLScheme:kCMTradeDayTrustURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMTradeDayAuthorize *dayAuth = [CMTradeDayAuthorize yy_modelWithDictionary:dict];
            [dayArr addObject:dayAuth];
        }
        kCMTableFoot_isPage
        success(dayArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//历史委托
+ (void)cm_tradeInquireFetchHistoryTrusetOnPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    kCMDict_page
    
    [CMRequestAPI postTradeFromURLScheme:kCMTradeHistoryURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMTradeDayAuthorize *dayAuth = [CMTradeDayAuthorize yy_modelWithDictionary:dict];
            [dayArr addObject:dayAuth];
        }
        kCMTableFoot_isPage
        success(dayArr,isPage);
    } fail:^(NSError *error) {
         fail(error);
    }];
    
}
//持有查询
+ (void)cm_tradeInquireFetchHoldProductOnPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    kCMDict_page
    
    [CMRequestAPI postTradeFromURLScheme:KCMTradeHoldProduct argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMHoldInquire  *dayAuth = [CMHoldInquire yy_modelWithDictionary:dict];
            [dayArr addObject:dayAuth];
        }
        kCMTableFoot_isPage
        success(dayArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//撤单
+ (void)cm_tradeinquireFetchRemoveOrderNumber:(NSInteger)ordeNumber success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    
    NSDictionary *dict = @{@"orderNum":CMNumberWithFormat(ordeNumber)};
    
    [CMRequestAPI postTradeFromURLScheme:kCMTradeRemoveURL argumentsDictionary:dict success:^(id responseObject) {
        NSInteger index = [responseObject[@"data"] integerValue];
        BOOL isWin = NO;
        if (index != 0) {
            isWin = YES;
        }
        success(isWin);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//可撤单列表
+ (void)cm_tradeinquireFetchRemoveListPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"page":CMNumberWithFormat(page)};
    
    [CMRequestAPI postTradeFromURLScheme:kCMTradeMayRemoveURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataRows = responseObject[@"data"][@"rows"];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in dataRows) {
            CMMayRemove *remove = [CMMayRemove yy_modelWithDictionary:dict];
            [dataArr addObject:remove];
        }
        NSInteger total = [responseObject[@"data"][@"total"] integerValue];
        
        BOOL isPage = NO;
        if (page * 10 < total) {
            isPage = YES;
        }
        success(dataArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//卖出
+ (void)cm_tradeInquireFetchSellPCode:(NSString *)code orderName:(NSString *)name orderPrice:(NSString *)orderPrice orderVolume:(NSString *)volume success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"PName":name,
                           @"PCode":code,
                           @"OrderPrice":orderPrice,
                           @"OrderVolume":volume
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMTradeSaleURL argumentsDictionary:dict success:^(id responseObject) {
        NSInteger index = [responseObject[@"data"] integerValue];
        BOOL isWin = NO;
        if (index != 0) {
            isWin = YES;
        }
        success(isWin);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//买入
+ (void)cm_tradeInquireFetchBuyingPCode:(NSString *)code orderPrice:(NSString *)price orderVolume:(NSString *)orderVolume orderName:(NSString *)name success:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"PName":name,
                           @"PCode":code,
                           @"OrderPrice":price,
                           @"OrderVolume":orderVolume
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMTradeBuyingURL argumentsDictionary:dict success:^(id responseObject) {
        NSInteger index = [responseObject[@"data"] integerValue];
        BOOL isWin = NO;
        if (index != 0) {
            isWin = YES;
        }
        success(isWin);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//产品检测
+ (void)cm_tradeInquireFetchPrductPcode:(NSString *)pcode direction:(NSString *)direction success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSString *productURL = [NSString stringWithFormat:@"%@/%@/%@",kCMProductBuingSaleURL,pcode,direction];
    
//    [CMRequestAPI getDataFromURLScheme:productURL argumentsDictionary:nil success:^(id responseObject) {
//        
//    } fail:^(NSError *error) {
//        
//    }];
    
    [CMRequestAPI postTradeFromURLScheme:productURL argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataStr = responseObject[@"data"];
        NSArray *dataArr = [dataStr componentsSeparatedByString:@","];
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

//成交列表
+ (void)cm_tradeInquireFetchDealOnPage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    kCMDict_page
    [CMRequestAPI postTradeFromURLScheme:kCMTradeTurnoverURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMTurnoverList *dayAuth = [CMTurnoverList yy_modelWithDictionary:dict];
           // NSLog(@"---%@,---%@",dayAuth.pName,dayAuth.pCode);
            [dayArr addObject:dayAuth];
        }
        NSInteger total = [responseObject[@"data"][@"total"] integerValue];
        
        BOOL isPage = NO;
        if (page * 10 < total) {
            isPage = YES;
        }
        success(dayArr,isPage);
    } fail:^(NSError *error) {
         fail(error);
    }];
}
//历史成交
+ (void)cm_tradeInquireFetchHistoryDealOnePage:(NSInteger)page success:(void (^)(NSArray *, BOOL))success fail:(void (^)(NSError *))fail {
    kCMDict_page
    //偷懒了。其实这个可以写一个方法。但是我比较懒。就没写。赶时间。空了可以抽出来重写
    [CMRequestAPI postTradeFromURLScheme:kCMTradeHistoryTurnoverURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMTurnoverList *dayAuth = [CMTurnoverList yy_modelWithDictionary:dict];
            [dayArr addObject:dayAuth];
        }
        NSInteger total = [responseObject[@"data"][@"total"] integerValue];
        
        BOOL isPage = NO;
        if (page * 10 < total) {
            isPage = YES;
        }
        
        success(dayArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//获取银行卡列表
+ (void)cm_tradeWithdrawFetchBankBlockListSuccess:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI postTradeFromURLScheme:kCMTradeBankBlockListURL argumentsDictionary:nil success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMBankBlockList *bankBlock = [CMBankBlockList yy_modelWithDictionary:dict];
            [dayArr addObject:bankBlock];
        }
        success(dayArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//提取现金
+ (void)cm_tradeWithdrawTransferExtractBankcardId:(NSInteger)bankcardId couponId:(NSInteger)couponId amount:(NSString *)amount vercode:(NSString *)vercode tradePassword:(NSString *)password provincecode:(NSString *)province citycode:(NSString *)city bankname:(NSString *)bank sccess:(void (^)(BOOL))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = nil;
    if (province != nil) {
        dict = @{
                 @"bankcardid": CMNumberWithFormat(bankcardId),
                 @"provincecode": province,
                 @"citycode": city,
                 @"bankname": bank,
                 @"couponid": CMNumberWithFormat(couponId),
                 @"amount": amount,
                 @"vercode": vercode,
                 @"tradepassword": password
                 };
    } else {
        dict = @{
                   @"bankcardid":CMNumberWithFormat(bankcardId),
                   @"couponid":CMNumberWithFormat(couponId),
                   @"amount":amount,
                   @"vercode":vercode,
                   @"tradepassword":password
                };
    }
    [CMRequestAPI postTradeFromURLScheme:kCMTradeWithdrawalURL argumentsDictionary:dict success:^(id responseObject) {
        success(YES);
    } fail:^(NSError *error) {
        fail(error);
    }];
}
//优惠券
+ (void)cm_tradeWithdrawFetchCouponlistListType:(NSInteger)type success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{
                           @"type":CMNumberWithFormat(type)
                           };
    [CMRequestAPI postTradeFromURLScheme:kCMTradeCouponlistURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"rows"];
        NSMutableArray *dayArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMBankBlockList *bankBlock = [CMBankBlockList yy_modelWithDictionary:dict];
            [dayArr addObject:bankBlock];
        }
        success(dayArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//个人账户信息
+ (void)cm_tradeFetchAccountionfSuccess:(void (^)(CMAccountinfo *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI postTradeFromURLScheme:kCMTradeAccountinfoURL argumentsDictionary:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        CMAccountinfo *tinfo = [CMAccountinfo yy_modelWithDictionary:dict];
        success(tinfo);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//中签查询
+ (void)cm_tradeFetchDrawProductPage:(NSInteger)page success:(void (^)(NSArray *,BOOL ))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"pageIndex":CMNumberWithFormat(page)};
    [CMRequestAPI postTradeFromURLScheme:kCMTradeDrawProductNumberURL argumentsDictionary:dict success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"data"][@"list"];
        NSMutableArray *contenArr = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            CMWinning *win = [CMWinning yy_modelWithDictionary:dict];
            [contenArr addObject:win];
        }
        BOOL isPage = NO;
        if (page < [responseObject[@"data"][@"totalpage"] integerValue]) {
            isPage = YES;
        }
        
        success(contenArr,isPage);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//企业信息
+ (void)cm_tradeFetchProductContextPcode:(NSInteger)pcode success:(void (^)(NSString *))success fail:(void (^)(NSError *))fail {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kMProductContextURL,CMNumberWithFormat(pcode)];
    
    [CMRequestAPI postDataFromURLScheme:urlStr argumentsDictionary:nil success:^(id responseObject) {
        NSString *dataStr = responseObject[@"data"];
        success(dataStr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
//省份
+ (void)cm_tradeFetchProvinceListSuccess:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    [CMRequestAPI postOrdinaryFromURLScheme:kCMTradeProvinceListURL argumentsDictionary:nil success:^(id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray *rowsArr = responseObject[@"data"][@"rows"];
        for (NSDictionary *dict in rowsArr) {
            CMProvinceList *province = [CMProvinceList yy_modelWithDictionary:dict];
            [dataArr addObject:province];
        }
        success(dataArr);
        
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
+ (void)cm_tradeFetchCityListProvincecode:(NSString *)province success:(void (^)(NSArray *))success fail:(void (^)(NSError *))fail {
    NSDictionary *dict = @{@"provincecode":province};
    [CMRequestAPI postDataFromURLScheme:kCMTradeCityListURL argumentsDictionary:dict success:^(id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray *rowsArr = responseObject[@"data"][@"rows"];
        for (NSDictionary *dict in rowsArr) {
            CMProvinceList *province = [CMProvinceList yy_modelWithDictionary:dict];
            [dataArr addObject:province];
        }
        success(dataArr);
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

@end



























