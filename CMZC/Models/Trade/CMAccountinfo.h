//
//  CMAccountinfo.h
//  CMZC
//
//  Created by 财猫 on 16/4/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAccountinfo : NSObject

@property (nonatomic,assign) CGFloat totalassets; //用户总资产
@property (nonatomic,assign) CGFloat totalmarketvalue; //用户持有产品的市值金额
@property (nonatomic,assign) CGFloat totalprofit; //用户持有产品的盈亏金额
@property (nonatomic,assign) CGFloat availableamount; //用户的可yong金额。
@property (nonatomic,assign) CGFloat desirableamount; //用户的可取金额
@property (nonatomic,copy) NSString *realname; //真实姓名
@property (nonatomic,assign) BOOL bankcardisexists; //用户是否绑定了银行卡

@end
