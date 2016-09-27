//
//  CMStatementViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  负责声明 交易所负责详解

typedef NS_ENUM(NSInteger,CMBaseViewDistinctionType) {
    CMBaseViewDistinctionTypeStatement, //责任声明
    CMBaseViewDistinctionTypeDetails //交易所规则详解
};

#import "CMBaseViewController.h"

@interface CMStatementViewController : CMBaseViewController

@property (nonatomic,assign) CMBaseViewDistinctionType baserType;

@end
