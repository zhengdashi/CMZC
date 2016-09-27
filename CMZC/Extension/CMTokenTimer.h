//
//  CMTokenTimer.h
//  CMZC
//
//  Created by 财猫 on 16/4/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessRequestBlock)(id responseObject);

@interface CMTokenTimer : NSObject
singleton_interface(CMTokenTimer);

- (void)cm_cmtokenTimerRefreshSuccess:(void(^)())success
                                 fail:(void(^)(NSError *error))fail;

@end
