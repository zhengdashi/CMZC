//
//  CMAnalystPoint.h
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAnalystPoint : NSObject

@property (nonatomic,copy) NSString *topicid; //观点id
@property (nonatomic,copy) NSString *username; //用户昵称
@property (nonatomic,copy) NSString *useravatar; // 用户头像地址
@property (nonatomic,copy) NSString *content; //观点内容
@property (nonatomic,copy) NSString *created; //观点时间
@property (nonatomic,copy) NSString *title; //标题

@end
