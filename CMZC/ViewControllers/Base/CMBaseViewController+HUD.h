//
//  CMBaseViewController+HUD.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController (HUD)

/**
 *  显示默认加载框
 */
- (void)showDefaultProgressHUD;

/**
 *  隐藏最新加入的加载框
 */
- (void)hiddenProgressHUD;

/**
 *  隐藏所有加载框
 */
- (void)hiddenAllProgressHUD;

/**
 *  弹出一个提示加载狂，两秒后隐藏
 *
 *  @param message 提示语句
 */
- (void)showAutoHiddenHUDWithMessage:(NSString *)message;

/**
 *  弹出一个加载狂，自定义时间和自定义提示语
 *
 *  @param message   提示语
 *  @param delayTime 时间
 */
- (void)showHUDWithMessage:(NSString *)message hiddenDelayTime:(NSTimeInterval)delayTime;
- (void)showIsLoginViewController;
@end
