//
//  CMRequestAPI+Login.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  注册 登录

#import "CMRequestAPI.h"
#import "CMAccount.h"

@interface CMRequestAPI (Login)

/**
 *  注册账户
 *
 *  @param number        手机号码
 *  @param vercode       短信验证码
 *  @param pasword       密码
 *  @param confimPasword 确认密码
 */
+ (void)cm_loginTransferDataPhoneNumber:(NSInteger)number
                           phoneVercode:(NSInteger)vercode
                               password:(NSString *)pasword
                         confimPassword:(NSString *)confimPasword
                                success:(void(^)(BOOL isSucceed))success
                                   fail:(void(^)(NSError *error))fail;

/**
 *  重置密码
 *
 *  @param number        手机号码
 *  @param vercode       短信验证码
 *  @param password      密码
 *  @param confimPasword 确认密码
 */
+ (void)cm_loginTransferResetPhoneNumber:(NSInteger)number
                            phoneVercode:(NSInteger)vercode
                                password:(NSString *)password
                          confimPassword:(NSString *)confimPasword
                                 success:(void(^)(BOOL isSucceed))success
                                    fail:(void(^)(NSError *error))fail;

/**
 *  登录
 *
 *  @param clientId app客户端id 这个是后台给的
 *  @param secret   app客户端迷失 这个是后台给
 *  @param number   用户名
 *  @param password 密码
 */
+ (void)cm_loginTransRegisterClientId:(NSString *)clientId
                         clientSecret:(NSString *)secret
                             userName:(NSString *)number
                             password:(NSString *)password
                              success:(void(^)(CMAccount *account))success
                                 fail:(void(^)(NSError *error))fail;

/**
 *  获取短信验证码
 *
 *  @param number  手机号
 */
+ (void)cm_toolFetchShortMessagePhoneNumber:(NSInteger)number
                                    success:(void(^)(BOOL isSucceed))success
                                       fail:(void(^)(NSError *error))fail;
/**
 *  刷新token的方法
 *
 *  @param refreshToken 原先的token
 *  @param success      成功
 *  @param fail         失败
 */
+ (void)cm_toolFetchRefreshToken:(NSString *)refreshToken
                         success:(void(^)(BOOL isWin))success
                            fail:(void(^)(NSError *error))fail;

@end






































