//
//  CMAccount.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAccount : NSObject<NSCoding>

@property (nonatomic,copy) NSString *userId; //用户id
@property (nonatomic,copy) NSString *userName;  //登录时输入用户名
@property (nonatomic,copy) NSString *password;  //d登录时的用户密码
@property (nonatomic,copy) NSString *access_token;  //授权令牌
@property (nonatomic,copy) NSString *refresh_token;  //刷新令牌
@property (nonatomic,copy) NSString *token_type;  //令牌类型
@property (nonatomic,copy) NSString *expires_in;  //有效时间

- (id)initWithDict:(NSDictionary *)dict;

@end
