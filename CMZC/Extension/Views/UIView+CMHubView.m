//
//  UIView+CMHubView.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "UIView+CMHubView.h"

@implementation UIView (CMHubView)

- (void)showHubView:(UIView *)hView messageStr:(NSString *)message time:(NSTimeInterval)tim {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:tim];
}

- (void)showHubTacit {
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (void)hideHubTacit {
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

@end
