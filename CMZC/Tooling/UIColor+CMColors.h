//
//  UIColor+CMColors.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 财毛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMColorModel.h"


@interface UIColor (CMColors)
+ (UIColor *) colorWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;
+ (CMColorModel *) RGBWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;
// 传入十六进制的颜色值 透明度为1
+ (UIColor *)clmHex:(UInt32)hex;

// 传入十六进制的颜色值 自定义透明度
+ (UIColor *)clmHex:(UInt32)hex alpha:(CGFloat)alpha;

// 传入rgb色值 透明度为1
+ (UIColor *)clmR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B;

#pragma mark - colors
/**
 *  主题红
 */
+ (UIColor *)cmThemeOrange;
/**
 *  背景灰色
 */
+ (UIColor *)cmBackgroundGrey;
/**
 *  tabbarBgColor
 */
+ (UIColor *)cmtabBarGreyColor;
/**
 *  行情详情页的view
 */
+ (UIColor *)CMBarGreyColor;

/**
 *  黑色
 */
+ (UIColor *)cmBlockColor;
/**
 *  半透明黑
 */
+ (UIColor *)cmBlackerColor;

/**
 *  默认二级字体颜色
 */
+ (UIColor *)cmTacitlyFontColor;
/**
 *  默认一级字体颜色
 */
+ (UIColor *)cmTacitlyOneColor;
/**
 *  666666hex的字体颜色 浅黑色
 */
+ (UIColor *)cmSomberColor;
/**
 *  999999
 */
+ (UIColor *)cmNineColor;

/**
 *  分割线颜色
 */
+ (UIColor *)cmDividerColor;
/**
 *  行情字体颜色
 */
+ (UIColor *)cmMarketDivider;
/**
 *  行情页 选中btn背景color
 */
+ (UIColor *)cmBtnBGColor;
/**
 *  行情页 btn的默认bg颜色
 */
+ (UIColor *)cmTacitlyBtnColor;
/**
 *  字体颜色  白色
 */
+ (UIColor *)cmFontWiteColor;
/**
 *  涨
 */
+ (UIColor *)cmUpColor;
/**
 *  跌
 */
+ (UIColor *)cmFallColor;
/**
 *  行情黑
 */
+ (UIColor *)cmMarkBlock;

@end
