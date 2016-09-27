//
//  CMPurchaseProduct.h
//  CMZC
//
//  Created by 财猫 on 16/4/18.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购列表

#import <Foundation/Foundation.h>

@interface CMPurchaseProduct : NSObject

@property (nonatomic,assign) NSInteger productId; //id产品id
@property (nonatomic,copy) NSString *title; //产品名称
@property (nonatomic,copy) NSString *descri; ///产品的描述
@property (nonatomic,copy) NSString *picture; //产品的图片地址
@property (nonatomic,copy) NSString *targetamount; //产品的众筹金额
@property (nonatomic,copy) NSString *currentamount; //产品的已申购金额
@property (nonatomic,copy) NSString *leadinvestor; //产品的领投人
@property (nonatomic,copy) NSString *income; //产品的预计收益
@property (nonatomic,copy) NSString *typeName; //产品的类型名称
@property (nonatomic,copy) NSString *position; //产品的发行人的位置
@property (nonatomic,copy) NSString *growthvalue; //产品的发行人的成长值
@property (nonatomic,copy) NSString *deadline; //产品的期限
@property (nonatomic,copy) NSString *starttime; //产品的申购开始时间
@property (nonatomic,copy) NSString *endtime; //产品的申购结束时间
@property (nonatomic,copy) NSString *status; //产品的状态
@property (nonatomic,assign) BOOL cansubscribe; //产品是否可以申购

- (NSMutableAttributedString *)attributed;

- (BOOL)isNextPage;


@end
