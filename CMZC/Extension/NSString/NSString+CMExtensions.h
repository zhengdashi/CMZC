//
//  NSString+CMExtensions.h
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CMExtensions)

/**
 *  检测是否为空字符串
 */
- (BOOL)isBlankString;

/**
 *   删除空格和换行
 */
- (NSString *)filtrateString;

/**
 *  验证手机号码格式
 */
-(BOOL)checkPhoneNumInput;
/**
 *  判断是否为浮点形：
 *
 *  @param string 传入字符串
 *
 *  @return yes 是
 */
- (BOOL)isPureFloat:(NSString*)string;

/**
*  判断是否包含特殊字符
*
*  @param string 传入需要判断的字符串
*
*  @return no 没有。 yes  有
*/
- (BOOL)checkIfHasSpecialCharacterInString:(NSString *)string;

/**
 *  判断长度是否大于6位，是否包含文字和字母
 *
 *  @param pass 要判断的文字
 *
 *  @return
 */
- (BOOL)judgePassWordLegal:(NSString *)pass;
    


/**
 *  判断字符串是否是整型
 *
 *  @param string 传入字符串
 *
 */
- (BOOL)isPureInt:(NSString*)string;

@end
#pragma mark - 网络请求错误提示语

@interface NSString (ErrorMessage)

+ (NSString *)errorMessageWithCode:(NSInteger)code;
/**
 *  注册请求错误提示语
 *
 *  @param code 错误代码
 */
+ (NSString *)longinErrorMessageWithCode:(NSInteger)code;

@end





#pragma mark - 计算字符串的高度和宽度

@interface NSString (CalculateWideHigh)

/**
 *  根据字符 得到高度
 *
 *  @param width   传入限制宽度
 *  @param sysFont 字体大小
 */
- (CGFloat)getHeightIncomingWidth:(CGFloat)width
                     incomingFont:(CGFloat)sysFont;

/**
 *  根据字符得到宽度
 *
 *  @param height  传入限制高度
 *  @param sysFont 字体大小
 */
- (CGFloat)getWidthIncomingHeight:(CGFloat)height
                     incomingFont:(CGFloat)sysFont;

/**
 *  传入size得到宽度或者高度
 *
 *  @param size    size
 *  @param sysFont 字体大小
 */
- (CGRect)getHeightOrWidthIncomingSize:(CGSize)size
                           icomingFont:(CGFloat)sysFont;

@end