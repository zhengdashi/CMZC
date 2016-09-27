//
//  CMRequestAPI.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  请求成功的回调
 *
 *  @param responseObject 请求成功的数据
 */
typedef void (^SuccessRequestBlock)(id responseObject);

/**
 *  请求失败
 *
 *  @param error 请求失败的错误信息
 */
typedef void (^FailRequestBlock)(NSError *error);

@interface CMRequestAPI : NSObject


/**
 *  不带touken的  post请求
 *
 *  @param urlScheme 请求的地址
 *  @param arguments 请求的参数
 *  @param success   成功的回调
 *  @param fail      失败的回调
 */
+ (void)postDataFromURLScheme:(NSString *)urlScheme
          argumentsDictionary:(NSDictionary *)arguments
                      success:(SuccessRequestBlock)success
                         fail:(FailRequestBlock)fail;

/**
 *  需要加入 请求头 touken 的post请求
 *
 *  @param urlScheme 请求地址
 *  @param arguments 请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (void)postTradeFromURLScheme:(NSString *)urlScheme
           argumentsDictionary:(NSDictionary *)arguments
                       success:(SuccessRequestBlock)success
                          fail:(FailRequestBlock)fail;
/**
 *  普通的 post 请求
 *
 *  @param urlScheme 请求地址
 *  @param arguments 请求参数
 *  @param success   陈宫回调
 *  @param fail      失败回调
 */
+ (void)postOrdinaryFromURLScheme:(NSString *)urlScheme
              argumentsDictionary:(NSDictionary *)arguments
                          success:(SuccessRequestBlock)success
                             fail:(FailRequestBlock)fail;


/**
 *  get请求
 *
 *  @param urlScheme 请求的地址
 *  @param arguments 请求的参数
 *  @param success   成功的回调
 *  @param fail      失败的回调
 */
+ (void)getDataFromURLScheme:(NSString *)urlScheme
          argumentsDictionary:(NSDictionary *)arguments
                      success:(SuccessRequestBlock)success
                         fail:(FailRequestBlock)fail;


@end
