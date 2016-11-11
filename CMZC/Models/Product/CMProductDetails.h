//
//  CMProductDetails.h
//  CMZC
//
//  Created by 郑浩然 on 16/10/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMLeadinVestor.h"

/*

"bank": Bank,
"starttime": StartTime,
"endtime": EndTime,
"status": Status,
"cansubscribe": CanSubscribe

*/

@interface CMProductDetails : NSObject
@property (nonatomic,assign) NSInteger productId; //产品id  不同类型
@property (nonatomic,copy) NSString *title;//产品名称
@property (nonatomic,copy) NSString *descri; //产品描绘  不同类型
@property (nonatomic,copy) NSString *detaileddescription; //产品介绍
@property (nonatomic,copy) NSString *picture; //产品图片地址
@property (nonatomic,copy) NSString *typeName; //产品类型名称  不同类型
@property (nonatomic,copy) NSString *tradecode; //产品交易代码
@property (nonatomic,copy) NSString *targetamount; //众筹金额
@property (nonatomic,copy) NSString *currentamount; //已申购金额
@property (nonatomic,copy) NSString *income; //预计收益
@property (nonatomic,copy) NSString *incometype; //收益类型
@property (nonatomic,copy) NSString *fixedincomedistribution; //保本收益分配
@property (nonatomic,copy) NSString *floatincomedistribution; //浮动收益分配
@property (nonatomic,copy) NSString *position; //发行人的位置
@property (nonatomic,assign) NSInteger growthvalue; //发行人的成长值
@property (nonatomic,copy) NSString *deadline; //产品的期限
@property (nonatomic,copy) NSString *progress; //产品进度百分比
@property (nonatomic,assign) NSInteger soldcount; //参与人数
@property (nonatomic,assign) NSInteger price; //单价
@property (nonatomic,assign) NSInteger startquantity; //起始申购份数
@property (nonatomic,copy) NSString *openingdeadline; //转让赎回期限
@property (nonatomic,copy) NSString *issuer; //发行人
@property (nonatomic,copy) NSString *sponsor; //保荐人名称
@property (nonatomic,copy) NSString *bank; //托管银行
@property (nonatomic,copy) NSString *starttime; // 开始时间
@property (nonatomic,copy) NSString *endtime; //结束时间
@property (nonatomic,copy) NSString *status; //产品状态
@property (nonatomic,copy) NSString *cansubscribe; //是否可申购

@property (strong, nonatomic) CMLeadinVestor *leadinvestor;


@end









