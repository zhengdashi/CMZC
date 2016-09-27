//
//  CMTradeTitleView.h
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易tableview的header

typedef NS_ENUM(NSInteger,CMTradeTitleViewType){
    CMTradeTitleViewTypeCertification,//认证过的
    CMTradeTitleViewTypeNotCertification //没有认证过
};

#import <UIKit/UIKit.h>
#import "CMAccountinfo.h"

@class CMTradeTitleView;

@protocol CMTradeTitleViewDelegate <NSObject>
/**
 *  点击提现
 *
 *  @param type 传入是否认证过。没认证过的去认证
 */
- (void)cm_tradeViewControllerType:(CMTradeTitleViewType)type;

/**
 *  点击登录
 *
 *  @param titleView 
 */
- (void)cm_tradeViewControllerLogin:(CMTradeTitleView *)titleView;
/**
 *  点击充值
 */
- (void)cm_tradeViewControllerRecharge:(CMTradeTitleView *)titleView;


@end

@interface CMTradeTitleView : UIView
@property (weak, nonatomic) IBOutlet UIView *loginView; //登录
@property (nonatomic,assign)CMTradeTitleViewType   tradeType;

@property (nonatomic,assign)id<CMTradeTitleViewDelegate>delegate;

@property (strong, nonatomic) CMAccountinfo *tinfo;

@end
