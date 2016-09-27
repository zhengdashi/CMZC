//
//  CMAnalystMode.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  分析师

#import <Foundation/Foundation.h>

@interface CMAnalystMode : NSObject

@property (nonatomic,assign) NSInteger analystId;  //id

@property (nonatomic,copy) NSString *name;//分析师名字
@property (nonatomic,copy) NSString *avatar;//分析师头像url
@property (nonatomic,copy) NSString *shortdescription; //分析师的简述
@property (nonatomic,copy) NSString *fulldescription; //分析师的详细介绍
@property (nonatomic,assign) NSInteger topiccount;//分析师的观点书
@property (nonatomic,assign) NSInteger replycount; //回答数
@property (strong, nonatomic) NSString *lastpublished; //最近回答日期
@property (nonatomic,copy) NSString *title;


@end
