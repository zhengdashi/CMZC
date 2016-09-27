//
//  CMExchangeInquire.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMExchangeInquire.h"

@implementation CMExchangeInquire

+ (NSString *)cm_exchangeTitNameIndex:(NSInteger)index trustType:(CMExchangeType)type{
    switch (index) {
        case 0:
            return @"产品名称";
            break;
        case 1:
            return @"交易代码";
            break;
        case 2:
            return @"买卖类别";
            break;
        case 3:
            return type == CMExchangeTypeTurnover ?@"成交价格":@"委托价格";
            break;
        case 4:
            return type == CMExchangeTypeTurnover ?@"成交份数":@"委托份数";
            break;
        case 5:
            return type == CMExchangeTypeTurnover ?@"成交金额":@"成交份数";
            break;
        case 6:
            return type == CMExchangeTypeTurnover ?@"成交时间":@"撤单份数";
            break;
        case 7:
            return type == CMExchangeTypeTurnover ?@"委托序号":@"委托日期";
            break;
        case 8:
            return type == CMExchangeTypeTurnover ?@"账号查询":@"账户";
            break;
        case 9:
            return type == CMExchangeTypeTurnover ?@"交易费":@"订单序号";
            break;
        case 10:
            return type == CMExchangeTypeTurnover ?@"备注":@"委托状态";
            break;
        default:
            return nil;
            break;
    }
    
}

+ (NSString *)cm_exchangeTradeDayIndex:(NSInteger)index tradeDay:(CMTradeDayAuthorize *)trade {
    switch (index) {
        case 0:
            return trade.pName;
            break;
        case 1:
            return trade.pCode;
            break;
        case 2:
            return trade.selldirection;
            break;
        case 3:
            return trade.orderPrice;
            break;
        case 4:
            return trade.orderVolume;
            break;
        case 5:
            return trade.volume;
            break;
        case 6:
        {
            if (trade.status == 4 || trade.status == 5 ) {
                NSInteger page = [trade.orderVolume integerValue] - [trade.volume integerValue];
                return CMStringWithFormat(page);
            } else {
                return @"0";
            }
        }
            break;
        case 7:
            return [NSString stringWithFormat:@"%@ %@",trade.orderDate,trade.orderTime];
            break;
        case 8:
        {
            NSString *userName = [CMAccountTool sharedCMAccountTool].currentAccount.userName;
            NSMutableString * strUer = [NSMutableString stringWithFormat:@"%@",userName];
            [strUer replaceCharactersInRange:NSMakeRange(5, 4) withString:@"****"];
            return strUer;
            
        }
            break;
        case 9:
            return trade.orderNum;
            break;
        case 10:
        {
            return trade.condition;
        }
            break;
        default:
            return nil;
            break;
    }
    
}

+ (NSString *)cm_exchangeTurnoverIndex:(NSInteger)index turnover:(CMTurnoverList *)turnover {
    switch (index) {
        case 0:
            return turnover.pName;
            break;
        case 1:
            return turnover.pCode;
            break;
        case 2:
            return turnover.cater;
            break;
        case 3:
            return turnover.price;
            break;
        case 4:
            return turnover.volume;
            break;
        case 5:
            return turnover.amount;
            break;
        case 6:
            return [NSString stringWithFormat:@"%@ %@",turnover.contractDate,turnover.contractTime];
            break;
        case 7:
            return turnover.orderNum;
            break;
        case 8:
        {
            NSString *userName = [CMAccountTool sharedCMAccountTool].currentAccount.userName;
            NSMutableString * strUer = [NSMutableString stringWithFormat:@"%@",userName];
            [strUer replaceCharactersInRange:NSMakeRange(5, 4) withString:@"****"];
            return strUer;
        }
            break;
        case 9:
            return turnover.commission;
            break;
        case 10:
            return @"---";
            break;
        default:
            return nil;
            break;
    }
}

+ (NSString *)cm_holdDetailsTileNameIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"持有市值";
            break;
        case 1:
            return @"持有份数";
            break;
        case 2:
            return @"持有盈亏";
            break;
        case 3:
            return @"盈亏比例";
            break;
        case 4:
            return @"现价";
            break;
        case 5:
            return @"成本";
            break;
        case 6:
            return @"可用份数";
            break;
        default:
            return nil;
            break;
    }
    
    
}
+ (NSString *)cm_holdDetailsTileNameIndex:(NSInteger)index holdDetails:(CMHoldInquire *)inquire {
    switch (index) {
        case 0:
            return inquire.marketValue;
            break;
        case 1:
            return inquire.equity;
            break;
        case 2:
            return inquire.floatingProfitLoss;
            break;
        case 3:
            return [NSString stringWithFormat:@"%@%%",inquire.proportionProfitLoss];
            break;
        case 4:
            return inquire.price;
            break;
        case 5:
            return inquire.costPrice;
            break;
        case 6:
            return inquire.availableEquity;
            break;
        default:
            return nil;
            break;
    }
}

@end
