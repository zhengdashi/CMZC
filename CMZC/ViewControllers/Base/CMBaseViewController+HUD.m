//
//  CMBaseViewController+HUD.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBaseViewController+HUD.h"

@implementation CMBaseViewController (HUD)

// 显示默认加载框
- (void)showDefaultProgressHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = nil;
}

// 隐藏最新加入的加载框
- (void)hiddenProgressHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// 隐藏所有的加载框
- (void)hiddenAllProgressHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

// 弹出一个1秒后自动隐藏的HUD
- (void)showAutoHiddenHUDWithMessage:(NSString *)message {
    [self showHUDWithMessage:message hiddenDelayTime:1.0];
}

// 弹出一个`delayTime`秒后自动隐藏的HUD
- (void)showHUDWithMessage:(NSString *)message hiddenDelayTime:(NSTimeInterval)delayTime {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    
    [hud hide:YES afterDelay:delayTime];
}

- (void)showIsLoginViewController {
    if (!CMIsLogin()) {
        UIViewController *logingVC = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:logingVC animated:YES completion:nil];
    }
}

@end
