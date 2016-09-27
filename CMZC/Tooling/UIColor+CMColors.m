//
//  UIColor+CMColors.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 财毛. All rights reserved.
//

#import "UIColor+CMColors.h"
#import "UIColor+CMHex.h"



@implementation UIColor (CMColors)
#pragma mark 16进制颜色转换
// color = #FFFFFF 或者 0xFFFFFF
+ (UIColor *) colorWithHexString: (NSString *)color withAlpha:(CGFloat)alpha
{
    unsigned int r, g, b;
    CMColorModel *rgb = [self RGBWithHexString:color withAlpha:alpha];
    r = rgb.R;
    g = rgb.G;
    b = rgb.B;
    alpha = rgb.alpha;
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

#pragma mark 16进制转换为RGB模式
+ (CMColorModel *) RGBWithHexString: (NSString *)color withAlpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return Nil;
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return Nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    CMColorModel *rgb = [[CMColorModel alloc] init];
    rgb.R = r;
    rgb.B = b;
    rgb.G = g;
    rgb.alpha = alpha;
    return  rgb;
}

//给一个十六进制的值
+ (UIColor *)clmHex:(UInt32)hex {
    return [UIColor colorWithHex:hex];
}
//给一个十六进制的值 自定义透明度
+ (UIColor *)clmHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithHex:hex andAlpha:alpha];
}

+ (UIColor *)clmR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

//主题橙色
+ (UIColor *)cmThemeOrange {
    return [UIColor colorWithHex:0xFF6400];         //253-110-5
}

//背景灰色
+ (UIColor *)cmBackgroundGrey {
    return [UIColor colorWithHex:0xeeeeee];     //234-234-234
}
//tabbar
+ (UIColor *)cmtabBarGreyColor {
    return [UIColor colorWithHex:0x1E1E1E];     //42 - 42 - 42 161616
}
+ (UIColor *)CMBarGreyColor {
    return [UIColor colorWithHex:0x111111];
}
//黑色
+ (UIColor *)cmBlockColor {
    return [UIColor colorWithHex:0x161616];    //22 - 22 -- 22
}
//半透明黑
+ (UIColor *)cmBlackerColor {
    return [UIColor colorWithHex:0x252525];  // 37 37 37
}
//默认二级字体颜色
+ (UIColor *)cmTacitlyFontColor {
    return [UIColor colorWithHex:0x666666];   //102 - 102 - 102
}
//默认一级字体颜色
+ (UIColor *)cmTacitlyOneColor {
    return [UIColor colorWithHex:0x666666];
}
//浅黑色
+ (UIColor *)cmSomberColor {
    return [UIColor colorWithHex:0x666666];
}
+ (UIColor *)cmNineColor {
    return [UIColor colorWithHex:0x999999];
}

//分割线颜色
+ (UIColor *)cmDividerColor {
    return [UIColor colorWithHex:0xE4E4E4];
}
+ (UIColor *)cmMarketDivider {
    return [UIColor colorWithHex:0x333333];
}


//交易也btn的北京color
+ (UIColor *)cmBtnBGColor {
    return [UIColor colorWithHex:0x222222];
}
//行情也默认的btn bg颜色
+ (UIColor *)cmTacitlyBtnColor {
    return [UIColor colorWithHex:0x525252];  // 82 82 82
}
//白色
+ (UIColor *)cmFontWiteColor {
    return [UIColor colorWithHex:0xFFFFFF];
}
//涨
+ (UIColor *)cmUpColor {
    return [UIColor colorWithHex:0xff0000]; // 240 21 3
}
//跌
+ (UIColor *)cmFallColor {
    return [UIColor colorWithHex:0x309830]; //38 137 39
}
+ (UIColor *)cmMarkBlock {
    return [UIColor colorWithHex:0x161616];
}
@end
