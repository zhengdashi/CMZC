//
//  UIColor+CMHex.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CMHex)



+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 *  给一个十六位进制的颜色
 *
 *  @param hex 十六进制的颜色
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHex:(UInt32)hex;
@end
