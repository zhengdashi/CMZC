//
//  CMAllServeViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  全部服务

#import "CMBaseViewController.h"

typedef NS_ENUM(NSInteger,CMAllServerViewType) {
    CMAllServerViewTypeAll, //什么都不是
    CMAllServerViewTypeSubscribe, //新品申购
    CMAllServerViewTypeMarket, //行情
    CMAllServerViewTypeAccount //我的账户
};

@protocol CMAllServerViewControllerDelegate <NSObject>

- (void)cm_allServerViewControllerPopHomeVCType:(CMAllServerViewType)type;

@end


@interface CMAllServeViewController : CMBaseViewController

@property (nonatomic,assign) CMAllServerViewType  allType;

@property (nonatomic,assign)id<CMAllServerViewControllerDelegate> delegate;

@end
