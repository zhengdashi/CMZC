//
//  CMProductDetailsViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  产品详情cell

#import "CMBaseViewController.h"

typedef NS_ENUM(NSInteger,CMProductSelectType) {
    CMProductSelectTypeComments, //评论
    CMProductSelectTypeNounce, //公告
    CMProductSelectTypeEnterprise, //企业信息
    CMProductSelectTypeDetails //闲情
};

@interface CMProductDetailsViewController : CMBaseViewController
@property (nonatomic,copy) NSString *productId;//行情id

@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,copy) NSString *codeName;

@property (nonatomic,assign) CMProductSelectType type;

@end
