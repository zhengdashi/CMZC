//
//  CMAnalystAnswer.h
//  CMZC
//
//  Created by 财猫 on 16/3/31.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  分析师回答

#import <Foundation/Foundation.h>

@interface CMAnalystAnswer : NSObject

@property (nonatomic,assign) NSInteger  topicid; //主题id
@property (nonatomic,copy) NSString *username; //主题发表人的名字
@property (nonatomic,copy) NSString *useravatar; //头像地址
@property (nonatomic,copy) NSString *content; //回复内容
@property (nonatomic,copy) NSString *created; //主题的发布时间

@property (strong, nonatomic) NSMutableArray *repliseArr; //回复列表

- (CGFloat)cellHeight;

@end

@interface CMAnalystViewpoint : NSObject

@property (nonatomic,assign) NSInteger replyid; //回复id
@property (nonatomic,copy) NSString *username; //回复发表人的用户昵称
@property (nonatomic,copy) NSString *useravatar; //回复认得投向地址
@property (nonatomic,copy) NSString *content; //回复内容
@property (nonatomic,copy) NSString *created; //回复时间

@end
