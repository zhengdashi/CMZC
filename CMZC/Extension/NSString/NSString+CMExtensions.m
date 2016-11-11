//
//  NSString+CMExtensions.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "NSString+CMExtensions.h"

@implementation NSString (CMExtensions)

// 检测是否为空字符串
- (BOOL)isBlankString {
    return !self.filtrateString.length;
}

// 删除空格和换行
- (NSString *)filtrateString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)checkPhoneNumInput {
    
    NSString * MOBILE = @"^1([0-9][0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
- (BOOL)checkIfHasSpecialCharacterInString:(NSString *)string {
        //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
        NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
        
        if (urgentRange.location == NSNotFound) {//没有
            return NO;
        } else {
            //有
            return YES;
        }
}
- (BOOL)judgePassWordLegal:(NSString *)pass {
    [pass filtrateString];
    BOOL result = NO;
    if (pass.length>6) {
        NSString *firstStr = [pass substringToIndex:1];
        NSString *ZIMU = @"^[A-Za-z]+$";
        NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
        if ([regextestA evaluateWithObject:firstStr]) {
            // 判断长度大于8位后再接着判断是否同时包含数字和字符
            NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [pred evaluateWithObject:pass];
        } else {
            result = NO;
        }
       
    }
    return result;
}

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
//判断字符串是否是整型
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

@end

#pragma mark - 网络请求错误提示语
@implementation NSString (ErrorMessage)

+ (NSString *)errorMessageWithCode:(NSInteger)code {
    NSString *msg;
    switch (code) {
        case 400:
            msg = @"服务器开小差，请稍后再试";
            break;
        case 401:
            msg = @"没权限访问";
            break;
        case 402:
            msg = @"地址不存在";
            break;
        case 10820:
            msg = @"请重试";
            break;
        case -1:
            msg = @"系统繁忙";
            break;
        case 20100:
            msg = @"请输入正确的产品编码";
            break;
        case 20101:
            msg = @"冻结新经板金额异常";
            break;
        case 20102:
            msg = @"增加冻结金额异常";
            break;
        case 20103:
            msg = @"买入异常";
            break;
        case 20190:
            msg = @"该产品停盘，不能交易";
            break;
        case 20110:
            msg = @"请检查编号是否正确";
            break;
        case 10104:
            msg = @"未能在请求中获取到正确的手机号";
            break;
        case 10105:
            msg = @"未能在请求中获取到用户名称";
            break;
        case 10106:
            msg = @"确认密码与密码不相同";
            break;
        case 10100:
            msg = @"用户名或密码不正确";
            break;
        case 10120:
            msg = @"请检查验证码或提现密码是否正确";
            break;
        case 10101:
            msg = @"当前手机号已被注册，可以直接登录";
            break;
        case 20106:
            msg = @"解冻新经板金额异常";
            break;
        case 20107:
            msg = @"解冻金额异常";
            break;
        case 20108:
            msg = @"更新持有产品异常";
            break;
        case 10110:
            msg = @"当前用户不存在";
            break;
        case 1010111:
            msg = @"请检查银行卡是否正确";
            break;
        case 10113:
            msg = @"请检查交易密码";
            break;
        case 10114:
            msg = @"请检查短信验证码";
            break;
        case 10115:
            msg = @"当前优惠券不存在";
            break;
        case 10116:
            msg = @"优惠券已被使用";
            break;
        case 10117:
            msg = @"优惠券已过期";
            break;
        case 20109:
            msg = @"更新持有产品异常";
            break;
        default:
            msg = @"网络异常，请重试";
            break;
    }
    return msg;
}

+ (NSString *)longinErrorMessageWithCode:(NSInteger)code {
    NSString *msg;
    switch (code) {
        case 10104:
            msg = @"未能在请求中获取到正确的手机号";
            break;
        case 10105:
            msg = @"未能在请求中获取到用户名称";
            break;
        case 10106:
            msg = @"确认密码与密码不相同";
            break;
        default:
            msg = @"该手机号已经注册，或验证码错误";
            break;
    }
    return msg;
}

@end;




#pragma mark - 计算字符串的高度和宽度

@implementation NSString (CalculateWideHigh)

//得到高度
- (CGFloat)getHeightIncomingWidth:(CGFloat)width incomingFont:(CGFloat)sysFont {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin |    NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:sysFont]}
                                     context:nil];
    return rect.size.height;
}
//得到宽度
- (CGFloat)getWidthIncomingHeight:(CGFloat)height incomingFont:(CGFloat)sysFont {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin |    NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:sysFont]}
                                     context:nil];
    return rect.size.width;
}

- (CGRect)getHeightOrWidthIncomingSize:(CGSize)size icomingFont:(CGFloat)sysFont {
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin |    NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:sysFont]}
                                     context:nil];
    return rect;
}

@end



















