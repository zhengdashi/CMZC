//
//  UIButton+CMButton.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CMButton)
/**
 *  创建默认的btn
 *
 *  @param title 名字
 */
+ (UIButton *)cm_customBtnTitle:(NSString *)title;

/**
 *  行情也默认btn 的bg颜色
 *
 *  @param btn 传入要改变btn的名字
 */
- (void)cm_setButtonAttr:(UIButton *)btn;

/**
 *  行情页 选中btn的bg颜色
 *
 *  @param btn 传入选中的btn
 */
- (void)cm_setButtonAttrWithClick:(UIButton *)btn;

/**
 *  初始化显示btn的样式。由于切图给了的单图片，所以这里要设置一下btn的显示格式
 *
 *  @param image 图片
 *  @param title 名字
 */
- (void)cm_setButtonRevealStyleImageName:(NSString *)image
                               titleName:(NSString *)title;

@end
