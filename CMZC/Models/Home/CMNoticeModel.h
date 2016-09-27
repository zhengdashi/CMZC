//
//  CMNoticeModel.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMNoticeModel : NSObject

@property (nonatomic,assign) NSInteger noticId;  //公告id
@property (nonatomic,copy) NSString *title;  //公告标题
@property (nonatomic,copy) NSString *descri;  //公告的简述
@property (nonatomic,copy) NSString *created;  //公告的发布时间

@property (nonatomic,copy) NSString *picture; //图片地址
@property (nonatomic,copy) NSString *link; //链接地址

@end
