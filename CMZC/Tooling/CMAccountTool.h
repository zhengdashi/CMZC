//
//  CMAccountTool.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMSingleton.h"
#import "CMAccount.h"

@interface CMAccountTool : NSObject
singleton_interface(CMAccountTool)

@property (strong, nonatomic) CMAccount *currentAccount;

@property (strong, nonatomic) NSMutableArray *accounts;

/**
 *  添加一个本地用户信息，并且设置为当前用户
 *
 *  @param account 用户实体对象
 */
- (void)addAccount:(CMAccount *)account;

/**
 *  清空当前用户信息
 */
- (void)removeAccount;

/**
 *  判断是否登录
 */
- (BOOL)isLogin;

/**
 *  保存当前用户信息
 */
- (void)save;

@end
