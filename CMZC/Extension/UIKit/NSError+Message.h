//
//  NSError+Message.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Message)

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)message;

/**
 *  请求成功的回调错误信息
 *
 *  @param requestObject 回调的错误信息
 */
+ (NSError *)errorResponseObject:(id)requestObject;

- (NSString *)message;


@end
