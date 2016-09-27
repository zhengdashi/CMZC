//
//  NSMutableAttributedString+AttributedString.m
//  CMZC
//
//  Created by 财猫 on 16/3/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "NSMutableAttributedString+AttributedString.h"

@implementation NSMutableAttributedString (AttributedString)

+ (NSMutableAttributedString *)cm_mutableAttributedString:(NSString *)str valueFont:(float)font valueColor:(UIColor *)color locRange:(CGFloat)loc lenRange:(CGFloat)len {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttributes:@{NSForegroundColorAttributeName:color,
                             NSFontAttributeName:[UIFont systemFontOfSize:font]
                             }
                     range:NSMakeRange(loc, len)];
    
    return attrStr;
}

@end
