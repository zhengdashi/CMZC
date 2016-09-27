//
//  CMTokenTimer.m
//  CMZC
//
//  Created by 财猫 on 16/4/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTokenTimer.h"

@implementation CMTokenTimer
singleton_implementation(CMTokenTimer);

- (void)cm_cmtokenTimerRefreshSuccess:(void (^)())success fail:(void (^)(NSError *))fail {
    NSInteger surplus = [self getSurplusTime];
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDateKey)timeIntervalSince1970];
    if (surplus <= 300) {
        if (lastTimeInterval >0) {
            [CMRequestAPI cm_toolFetchRefreshToken:[CMAccountTool sharedCMAccountTool].currentAccount.refresh_token success:^(BOOL isWin) {
                DeleteDataFromNSUserDefaults(kVerifyStarDateKey);
                SaveDataToNSUserDefaults([NSDate date], kVerifyStarDateKey);
                //刷新成功
                MyLog(@"token时间过期。刷新时间");
                success();
            } fail:^(NSError *error) {
                MyLog(@"令牌刷新失败");
                fail(error);
            }];
        } else {
            MyLog(@"没有登录账号");
            success();
        }
    } else {
        MyLog(@"token时间没过期");
        success();
    }
}


- (NSInteger)getSurplusTime {
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDateKey)timeIntervalSince1970];
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSInteger timeInterval = nowTimeInterval - lastTimeInterval;
    NSInteger surplus = [[CMAccountTool sharedCMAccountTool].currentAccount.expires_in integerValue] - timeInterval;
    return surplus;
}


@end
