//
//  CMTurnoverList.h
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  成交

#import <Foundation/Foundation.h>

@interface CMTurnoverList : NSObject

@property (nonatomic,copy) NSString *contractNum; //成交编号
@property (nonatomic,assign) NSInteger hyid; //账户id
@property (nonatomic,copy) NSString *orderNum; //委托编号
@property (nonatomic,copy) NSString *pName; //产品名称
@property (nonatomic,copy) NSString *pCode; //产品代码
@property (nonatomic,assign) NSInteger direction; //是否 买卖
@property (nonatomic,copy) NSString *price; //成交价格
@property (nonatomic,copy) NSString *volume; //成交量
@property (nonatomic,copy) NSString *amount; //成交金额
@property (nonatomic,copy) NSString *commission; //佣金
@property (nonatomic,copy) NSString *otherFee; //交易费
@property (nonatomic,copy) NSString *transferFee; //过户费
@property (nonatomic,assign) NSInteger status; //委托状态
@property (nonatomic,copy) NSString *contractDate; //成交日期
@property (nonatomic,copy) NSString *contractTime; //成交时间
//@property (nonatomic,copy) NSString *commission; //佣金


- (NSString *)cater;

@end
