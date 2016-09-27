//
//  UIView+Plus.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  view左边的扩展

#import <UIKit/UIKit.h>

@interface UIView (Plus)

/**
 *  从Nib文件初始化,nib文件名需要与类名相同
 *
 *  @return view实例
 */
+ (instancetype)initByNibForClassName;

/**
 *  显示view
 *
 *  @param view 要现实的view
 */
- (void)showMeToView:(UIView *)view;

/**
 *  删除view
 *
 *  @param view 传入的view
 */
- (void)removeMeFromView:(UIView*)view;


/**
 *  得到view的X轴坐标
 */
- (CGFloat)x;

/**
 *  得到view的y轴坐标
 */
- (CGFloat)y;

/**
 *  自定义view的x轴坐标
 *
 *  @param x 传入x轴的坐标
 */
- (void)setX:(CGFloat)x;

/**
 *  自定义view的y轴坐标
 *
 *  @param y 传入y轴
 */
- (void)setY:(CGFloat)y;

/**
 *  得到view的宽
 */
- (CGFloat)width;

/**
 *  得到view的高
 */
- (CGFloat)height;

/**
 *  得到屏幕的宽度
 */
- (CGFloat)screenWidth;


/**
 *  自动调整布局
 *
 *  @param subView 传入要调整的view
 */
- (void)viewLayoutAllEdgesOfSubview:(UIView *)subView;

/**
 *  获取屏幕的宽度
 */
CGFloat CMScreen_width();

/**
 *  获得屏幕的高度
 */
CGFloat CMScreen_height();

@end































