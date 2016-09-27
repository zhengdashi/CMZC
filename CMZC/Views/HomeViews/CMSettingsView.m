//
//  CMSettingsView.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSettingsView.h"

@implementation CMSettingsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)settingsBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cm_settingsViewDelegate:)]) {
        [self.delegate cm_settingsViewDelegate:self];
    }
    
}

@end
