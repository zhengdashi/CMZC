//
//  UIColor+CMHex.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "UIColor+CMHex.h"

@implementation UIColor (CMHex)
//自定透明度
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}
// 透明度是1的color
+ (UIColor *)colorWithHex:(UInt32)hex {
    return [self colorWithHex:hex andAlpha:1.0];
}
@end
