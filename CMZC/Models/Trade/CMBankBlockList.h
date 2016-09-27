//
//  CMBankBlockList.h
//  CMZC
//
//  Created by 财猫 on 16/4/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBankBlockList : NSObject

@property (nonatomic,assign) NSInteger bankcardid; //银行卡id
@property (nonatomic,copy) NSString *banktype; //银行卡类型
@property (nonatomic,copy) NSString *number; //银行卡卡号
@property (nonatomic,copy) NSString *balance; //银行卡可提余额
@property (nonatomic,assign) BOOL lackofinfo; //表示是否缺少银行卡信息部分
@property (nonatomic,assign) BOOL authentication; //是否认证

@property (nonatomic,assign) BOOL isSelect; //是否选中
//这里应该在创建一个类。因为后边有要用到相同的方法。所以我就写到一起了
@property (nonatomic,assign) NSInteger couponid;  //优惠券id
@property (nonatomic,copy) NSString *amount; //优惠券的金额
@property (nonatomic,copy) NSString *validitydate; //优惠券失效时间


@end
