//
//  CMTopicList.h
//  CMZC
//
//  Created by 郑浩然 on 17/1/11.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CMTopicList : NSObject

@property (nonatomic,copy) NSString *topicid; //活体id
@property (nonatomic,copy) NSString *username; //话题名字
@property (nonatomic,copy) NSString *userphoto; //头像地址
@property (nonatomic,copy) NSString *content; //回复内容
@property (nonatomic,copy) NSString *formatdate; //回复时间
@property (strong, nonatomic) NSArray *repliesArr; //包含的回复

@end



