//
//  CMExchangeInquire.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  成交查询

#import <Foundation/Foundation.h>
#import "CMTradeDayAuthorize.h"
#import "CMTurnoverList.h"
#import "CMHoldInquire.h"


typedef NS_ENUM(NSInteger,CMExchangeType){
    CMExchangeTypeTurnover, //成交
    CMExchangeTypeTrust //委托
};

@interface CMExchangeInquire : NSObject

@property (strong, nonatomic) CMTradeDayAuthorize *tradeDay;

/**
 *  传入index  返回对应的标题名字
 *
 *  @param indexPath 传入index
 */
+ (NSString *)cm_exchangeTitNameIndex:(NSInteger)index trustType:(CMExchangeType)type;
/**
 *  查询委托
 *
 *  @param index index
 *  @param trade 类
 */
+ (NSString *)cm_exchangeTradeDayIndex:(NSInteger)index tradeDay:(CMTradeDayAuthorize *)trade;
/**
 *  成交查询
 *
 *  @param index    index
 *  @param turnover 类
 *
 *  @return <#return value description#>
 */
+ (NSString *)cm_exchangeTurnoverIndex:(NSInteger)index turnover:(CMTurnoverList *)turnover;




+ (NSString *)cm_holdDetailsTileNameIndex:(NSInteger)index;

+ (NSString *)cm_holdDetailsTileNameIndex:(NSInteger)index holdDetails:(CMHoldInquire *)inquire;



@end
