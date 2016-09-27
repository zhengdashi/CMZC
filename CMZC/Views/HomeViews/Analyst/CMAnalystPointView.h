//
//  CMAnalystPointView.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  分析师详情   -- 观点

#import <UIKit/UIKit.h>

@class CMAnalystPoint;

typedef NS_ENUM(NSInteger ,CMAnalystPointType) {
    CMAnalystPointTypeOld,  //上滑
    CMAnalystPointTypeNew   //下拉
};



typedef void(^CMAnalystPointBlock)(CMAnalystPointType);

//跳转到观点详情
typedef void(^CMAnalystPointDetialsBlock)(CMAnalystPoint  *point);

@interface CMAnalystPointView : UIView
@property (nonatomic,assign) BOOL isAnimating;

@property (nonatomic,copy) CMAnalystPointBlock block;

@property (nonatomic,copy) CMAnalystPointDetialsBlock pointBlock;

@property (nonatomic,assign) NSInteger analystId; //分析师id

@end
