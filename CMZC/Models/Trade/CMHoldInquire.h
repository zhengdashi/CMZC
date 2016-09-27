//
//  CMHoldInquire.h
//  CMZC
//
//  Created by 财猫 on 16/4/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  查询

#import <Foundation/Foundation.h>

@interface CMHoldInquire : NSObject

@property (nonatomic,copy) NSString *availableEquity; //可用份数
@property (nonatomic,copy) NSString *costPrice; //成本价
@property (nonatomic,copy) NSString *equity; //份数余额
@property (nonatomic,copy) NSString *floatingProfitLoss; //浮动盈亏
@property (nonatomic,copy) NSString *holdProductId; //
@property (nonatomic,copy) NSString *hyid; //账户ID
@property (nonatomic,copy) NSString *marketValue; //当前市值
@property (nonatomic,copy) NSString *pCode; //产品代码
@property (nonatomic,copy) NSString *pName; //产品名称
@property (nonatomic,copy) NSString *price; //当前价
@property (nonatomic,copy) NSString *proportionProfitLoss; //盈亏比例%



@end
