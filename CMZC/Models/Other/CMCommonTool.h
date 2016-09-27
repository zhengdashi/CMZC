//
//  CMCommonTool.h
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCommonTool : NSObject

#pragma mark - 处理NSUserDefaults
/**
*  得到数据
*
*  @param key 传入key
*/
id GetDataFromNSUserDefaults(NSString *key);

/**
 *  删除数据
 *
 *  @param key 传入key
 */

void DeleteDataFromNSUserDefaults(NSString * key);

/**
 *  保存数据
 *
 *  @param data 传入value
 *  @param key  传入key
 */
void SaveDataToNSUserDefaults(id data, NSString *key);


/**
 *  判断是否登录
 */
BOOL CMIsLogin();

/**
 *  int 转换成string
 */
NSString *CMStringWithFormat(NSInteger index);
/**
 *  拼接两个字符串
 *
 *  @param keyStr   前边
 *  @param keyValue 后边
 */
NSString *CMStringWithPickFormat(NSString *keyStr, NSString *keyValue);
/**
 *  int转换成Number
 */
NSNumber *CMNumberWithFormat(NSInteger index);

/**
 *  延迟时间执行
 */
+ (void)executeRunloop:(void(^)())runloop afterDelay:(float)delay;

+(NSDate*)dateFromString:(NSString*)str;
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;
+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta;
+(NSObject *) getUserDefaults:(NSString *) name;
+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key;
+ (NSString *)md5HexDigest:(NSString*)password;
+(NSString*)changePrice:(CGFloat)price;
@end
