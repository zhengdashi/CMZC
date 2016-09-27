//
//  CMMayRemove.h
//  CMZC
//
//  Created by 财猫 on 16/6/3.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMayRemove : NSObject

@property (nonatomic,assign) NSInteger direction; //买卖方向
@property (nonatomic,copy) NSString *orderDate; //委托日期
@property (nonatomic,copy) NSString *orderNum; //委托编号
@property (nonatomic,copy) NSString *orderPrice; //委托价格
@property (nonatomic,copy) NSString *orderTime; //委托时间
@property (nonatomic,copy) NSString *orderVolume; //委托数量
@property (nonatomic,copy) NSString *pCode; //产品代码
@property (nonatomic,copy) NSString *pName; //产品名称
@property (nonatomic,copy) NSString *reason; //废单原因
@property (nonatomic,assign) NSInteger status; //委托状态
@property (nonatomic,copy) NSString *volume; //成交数量


- (NSString *)selldire;
- (NSString *)condition;
@end
