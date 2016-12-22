//
//  CMProductNotion.h
//  CMZC
//
//  Created by 财猫 on 16/6/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMProductNotion : NSObject

@property (nonatomic,assign) NSInteger notionId; //id
@property (strong, nonatomic) NSString *title; //标题
@property (strong, nonatomic) NSString *descri;
@property (strong, nonatomic) NSString *created; //时间

@end
