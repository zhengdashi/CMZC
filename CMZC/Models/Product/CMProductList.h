//
//  CMProductList.h
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购详情

#import <Foundation/Foundation.h>

@interface CMLeadinvestor : NSObject

@property (nonatomic,copy) NSString *name; //产品的领投人名称
@property (nonatomic,copy) NSString *logo; //产品的领投人Logo
@property (nonatomic,copy) NSString *investamount; //产品的领投人申购金额
@property (nonatomic,copy) NSString *ispayed; //产品的领投人是否已支付申购金额


@end

@interface CMProductList : NSObject

@property (nonatomic,assign) NSInteger productId; //产品id   不一样 需要改
@property (nonatomic,copy) NSString *title; // 产品名称
@property (nonatomic,copy) NSString *descri; //产品描述   不一样需要改
@property (nonatomic,copy) NSString *picture; //产品的图片地址
@property (nonatomic,copy) NSString *typeName; //产品的类型名称  不一样需要改
@property (nonatomic,copy) NSString *tradecode; // 交易代码
@property (nonatomic,copy) NSString *targetamount; //众筹金额
@property (nonatomic,copy) NSString *currentamount; //已申购金额
@property (nonatomic,copy) NSString *income; //预计收益
@property (nonatomic,copy) NSString *incometype; //收益类型
@property (nonatomic,copy) NSString *fixedincomedistribution; //保底收益分配
@property (nonatomic,copy) NSString *floatincomedistribution; //浮动收益分配
@property (nonatomic,copy) NSString *position; //产品发行人的位置
@property (nonatomic,copy) NSString *growthvalue; //发行人的成长值
@property (nonatomic,copy) NSString *deadline; //产品的期限
@property (nonatomic,copy) NSString *progress; //产品的众筹进度百分比
@property (nonatomic,copy) NSString *soldcount; //产品的参与人数
@property (nonatomic,copy) NSString *price; //产品的单价
@property (nonatomic,copy) NSString *startquantity; //产品的起始申购份数
@property (nonatomic,copy) NSString *openingdeadline; //产品的转让赎回期限
@property (nonatomic,copy) NSString *issuer; //产品的发行人
@property (nonatomic,copy) NSString *sponsor; //产品的保荐人名称
@property (nonatomic,copy) NSString *bank; //产品的托管银行
@property (nonatomic,copy) NSString *starttime; //产品的申购开始时间
@property (nonatomic,copy) NSString *endtime; //产品的申购结束时间
@property (nonatomic,copy) NSString *status; //产品的状态
@property (nonatomic,assign) BOOL cansubscribe; //产品是否可以申购
@property (strong, nonatomic) CMLeadinvestor *leadinvestor;



//标记是否可申购


@end


