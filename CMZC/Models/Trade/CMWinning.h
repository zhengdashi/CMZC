//
//  CMWinning.h
//  CMZC
//
//  Created by 财猫 on 16/5/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  中奖

#import <Foundation/Foundation.h>

@interface CMWinning : NSObject

@property (nonatomic,copy) NSString *pName; //产品名称
@property (nonatomic,copy) NSString *jyCode; //交易代码
@property (nonatomic,copy) NSString *jpamount; //申购金额
@property (nonatomic,copy) NSString *jpamountForSucess; //中签份数
@property (nonatomic,copy) NSString *numCount; //中签份数
@property (nonatomic,copy) NSString *zqList; //中签号码
@property (nonatomic,copy) NSString *zqNum; //中签数量
@property (nonatomic,copy) NSString *phtime; //配号时间
@property (nonatomic,copy) NSString *jptime; //竞拍时间

@end
