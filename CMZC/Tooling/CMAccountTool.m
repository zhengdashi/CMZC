//
//  CMAccountTool.m
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//
#define kFileName @"accounts.data"
#define kCurrentName @"currentAccount.data"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]
#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kCurrentName]

#import "CMAccountTool.h"

@implementation CMAccountTool
singleton_implementation(CMAccountTool)

- (instancetype)init {
    if (self = [super init]) {
        _accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentPath];
        if (_accounts == nil) {
            _accounts = [NSMutableArray array];
        }
    }
    return self;
}

- (void)addAccount:(CMAccount *)account {
    //这里加个判断，有相同手机号的就不要添加
    NSInteger theSameSum = 0;
    for (CMAccount *ac in _accounts) {
        if ([ac isKindOfClass:[CMAccount class]]) {
            if ([account.userName isEqualToString:ac.userName]) {
                theSameSum ++;
            }
        }
    }
    if (0 == theSameSum && account) {
        [_accounts addObject:account];
    }
    _currentAccount = account;
    
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
    [NSKeyedArchiver archiveRootObject:_accounts toFile:kFilePath];
}

- (BOOL)isLogin {
    return (self.currentAccount&&self.currentAccount.userName.length>0&&self.currentAccount.password.length>0 &&self.currentAccount.access_token.length > 0);
}


- (void)removeAccount {
    _currentAccount.userId = @"";
    _currentAccount.userName = @"";
    _currentAccount.password = @"";
    _currentAccount.access_token = @"";
    _currentAccount.refresh_token = @"";
    _currentAccount.token_type = @"";
    _currentAccount.expires_in = @"";
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
}


- (void)save {
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
}

@end

























