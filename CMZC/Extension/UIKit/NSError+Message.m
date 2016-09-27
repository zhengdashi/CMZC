//
//  NSError+Message.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "NSError+Message.h"
NSString *const kNSErrorUserInfoMessage = @"kNSErrorUserInfoMessage";

@implementation NSError (Message)


+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)message {
    return [NSError errorWithDomain:domain code:code userInfo:@{kNSErrorUserInfoMessage : message}];
}

+ (NSError *)errorResponseObject:(id)requestObject {
    return [NSError errorWithDomain:requestObject[@"errmsg"] code:[requestObject[@"errcode"]integerValue] message:requestObject[@"errmsg"]];
}

- (NSString *)message {
    return self.userInfo[kNSErrorUserInfoMessage];
}


@end
