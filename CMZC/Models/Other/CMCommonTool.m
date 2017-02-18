//
//  CMCommonTool.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCommonTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CMCommonTool
#pragma mark - 处理NSUserDefaults

//得到数据
id GetDataFromNSUserDefaults(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}
//删除所在的key的数据
void DeleteDataFromNSUserDefaults(NSString * key){
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//保存数据
void SaveDataToNSUserDefaults(id data, NSString *key){
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//判断是否登录
BOOL CMIsLogin() {
    if ([CMAccountTool sharedCMAccountTool].isLogin) {
        return YES;
    } else {
        return NO;
    }
}
//将int转换成 str
NSString *CMStringWithFormat(NSInteger index) {
    return [NSString stringWithFormat:@"%ld",(long)index];
}
NSString *CMFloatStringWithFormat(CGFloat index) {
    return [NSString stringWithFormat:@"%.2f",index];
}
//拼接字符串
NSString *CMStringWithPickFormat(NSString *keyStr, NSString *keyValue) {
    return [NSString stringWithFormat:@"%@%@",keyStr,keyValue];
}
//int 转换成number
NSNumber *CMNumberWithFormat(NSInteger index) {
    return [NSNumber numberWithInteger:index];
}

//延迟执行
+ (void)executeRunloop:(void (^)())runloop afterDelay:(float)delay {
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (runloop) {
            runloop();
        }
    });
}

#pragma mark 字符串转换为日期时间对象
+(NSDate*)dateFromString:(NSString*)str{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"yyyy-MM-dd"];
    // 将字符串转换为时间对象
    NSDate *tempDate = [datef dateFromString:str];
    return tempDate;
}

#pragma mark 时间对象转换为时间字段信息
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    if (date==nil) {
        date = [NSDate date];
    }
    //    // 获取代表公历的Calendar对象
    //    NSCalendar *calenar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    // 定义一个时间段的旗标，指定将会获取指定的年，月，日，时，分，秒的信息
    //    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    //    // 获取不同时间字段信息
    //    NSDateComponents *dateComp = [calenar components:unitFlags fromDate:date];
    NSCalendar * calendar = [NSCalendar currentCalendar];//当前用户的calendar
    NSDateComponents * components = [calendar components:NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitDay fromDate:date];
    return components;
}

+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta
{
    int i1, i2;
    i1 = (f1>0) ? ((int)f1) : ((int)f1 - 0x80000000);
    i2 = (f2>0) ? ((int)f2)  : ((int)f2 - 0x80000000);
    return ((abs(i1-i2))<absDelta) ? true : false;
}

+(NSObject *) getUserDefaults:(NSString *) name{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:name];
}

+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:defaults forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// MD5 16位加密
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}

// 数值变化
+(NSString*)changePrice:(CGFloat)price{
    CGFloat newPrice = 0;
    NSString *danwei = @"万";
    if ((int)price>10000) {
        newPrice = price / 10000 ;
    }
    if ((int)price>10000000) {
        newPrice = price / 10000000 ;
        danwei = @"千万";
    }
    if ((int)price>100000000) {
        newPrice = price / 100000000 ;
        danwei = @"亿";
    }
    NSString *newstr = [[NSString alloc] initWithFormat:@"%.0f%@",newPrice,danwei];
    return newstr;
}

@end
