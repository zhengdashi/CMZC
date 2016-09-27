//
//  CMWebSocket.m
//  CMZC
//
//  Created by 财猫 on 16/5/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMWebSocket.h"

@interface CMWebSocket ()<SRWebSocketDelegate> {
    
}
@property (strong, nonatomic) SRWebSocket *webSocket;


@end


@implementation CMWebSocket


+ (CMWebSocket *)sharedAPI {
    static CMWebSocket *_sharedRequestAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRequestAPI = [[CMWebSocket alloc] init];
    });
    return _sharedRequestAPI;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        //[self reconnect];
        
    }
    return self;
}
- (instancetype)initRequestUrl:(NSString *)url {
    self = [super init];
    if (self) {
        [self reconnectUrlReques:url];
    }
    return self;
}
//初始化
- (void)reconnectUrlReques:(NSString *)requestUrl {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",requestUrl]]]];
    self.webSocket.delegate = self;
    
    //self.title = @"Opening Connection...";
    
    [self.webSocket open];
    
}
#pragma mark - SRWebSocketDelegate
//发送请求
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
    //self.title = @"Connected!";
    //发送消息
    [_webSocket send:@":range:desc::"];
}
- (void)send:(NSString *)send {
    [self.webSocket send:send];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    // self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"---%@",message);
    if ([self.delegate respondsToSelector:@selector(cm_webScketMessage:)]) {
        [self.delegate cm_webScketMessage:message];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"---%@",reply);
}

- (void)close {
    if (self.webSocket) {
        self.webSocket.delegate = nil;
        [self.webSocket close];
    }
}


@end
