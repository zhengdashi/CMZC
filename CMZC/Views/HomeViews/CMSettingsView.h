//
//  CMSettingsView.h
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  设置的退出按钮

#import <UIKit/UIKit.h>

@class CMSettingsView;
@protocol CMSettingsViewDelegate <NSObject>
/**
 *  点击按钮的delegate
 */
- (void)cm_settingsViewDelegate:(CMSettingsView *)settings;

@end

@interface CMSettingsView : UIView

@property (nonatomic,assign)id<CMSettingsViewDelegate>delegate;

@end
