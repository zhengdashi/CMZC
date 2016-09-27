//
//  NSMutableAttributedString+AttributedString.h
//  CMZC
//
//  Created by 财猫 on 16/3/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (AttributedString)
/**
 *  富文本，本来想这简单点。创建之后谁知道跟原来一样麻烦。既然创建了，就将就着用吧。有合适了，可以修改下
 *
 *  @param str   文字
 *  @param font  字体大小
 *  @param color 要改变的颜色
 *  @param loc   从第几个开始
 *  @param len   到第几个
 *
 */
+ (NSMutableAttributedString *)cm_mutableAttributedString:(NSString *)str
                                                valueFont:(float)font
                                               valueColor:(UIColor *)color
                                                 locRange:(CGFloat)loc
                                                 lenRange:(CGFloat)len;
@end
