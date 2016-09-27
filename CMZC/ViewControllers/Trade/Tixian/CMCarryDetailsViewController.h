//
//  CMCarryDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/18.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  提现二级界面

#import "CMBaseViewController.h"
#import "CMBankBlockList.h"


typedef NS_ENUM(NSInteger ,CMCaryDetailsStype) {
    CMCaryDetailsStypeBlack, //银行卡
    CMCaryDetailsStyperoll //优惠券
};

typedef NS_ENUM(NSInteger, CMCarryDetailsViewType) {
    CMCarryDetailsViewTypeRight,//不需要填写信息
    CMCarryDetailsViewTypeneed //需要填写信息
};


@interface CMCarryDetailsViewController : CMBaseViewController

@property (strong, nonatomic) NSArray *bankArr;

@property (nonatomic,assign) CMCaryDetailsStype stype;

@property (nonatomic,assign) CMCarryDetailsViewType carryType;

@property (nonatomic,copy) NSString *nameStr; //真实姓名

@property (nonatomic,copy) NSString *proviceName;//省份

@property (nonatomic,copy) NSString *cityName; //城市

@property (nonatomic,copy) NSString *bankName; //银行名字

@property (strong, nonatomic) CMBankBlockList *bankBlockList; //银行卡信息

@end
