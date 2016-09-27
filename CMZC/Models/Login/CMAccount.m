//
//  CMAccount.m
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAccount.h"

#define kUserName @"LoginUser"
#define kPassword @"LoginPas"
#define kAccessToken @"accessToken"
#define kRefreshToken @"refresh_token"
#define kTokenType @"tokenType"
#define kExpiresIn @"expiresIn"

@implementation CMAccount

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.access_token = dict[@"access_token"];
        self.refresh_token = dict[@"refresh_token"];
        self.token_type = dict[@"token_type"];
        self.expires_in = dict[@"expires_in"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:kUserName];
        self.password = [aDecoder decodeObjectForKey:kPassword];
        self.access_token = [aDecoder decodeObjectForKey:kAccessToken];
        self.refresh_token = [aDecoder decodeObjectForKey:kPassword];
        self.token_type = [aDecoder decodeObjectForKey:kTokenType];
        self.expires_in = [aDecoder decodeObjectForKey:kExpiresIn];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:kUserName];
    [aCoder encodeObject:self.password forKey:kPassword];
    [aCoder encodeObject:self.access_token forKey:kAccessToken];
    [aCoder encodeObject:self.refresh_token forKey:kRefreshToken];
    [aCoder encodeObject:self.token_type forKey:kTokenType];
    [aCoder encodeObject:self.expires_in forKey:kExpiresIn];
}

@end


















