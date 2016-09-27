//
//  CMWebSocket.h
//  CMZC
//
//  Created by 财猫 on 16/5/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>


@protocol CMWebSocketDelegate <NSObject>
/**
 *  返回数据的时候调用的
 *
 *  @param message 返回的数据
 */
- (void)cm_webScketMessage:(NSString *)message;

@end


@interface CMWebSocket : NSObject

@property (nonatomic,assign)id<CMWebSocketDelegate> delegate;
+ (CMWebSocket *)sharedAPI;

- (instancetype)initRequestUrl:(NSString *)url;

/**
 *  初始化
 *
 *  @param requestUrl 链接地址
 */
- (void)reconnectUrlReques:(NSString *)requestUrl;
/**
 *  关闭
 */
- (void)close;

/**
 *  发送消息
 */

- (void)send:(NSString *)send;

@end
