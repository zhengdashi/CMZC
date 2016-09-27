//
//  CMMediaNews.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMediaNews : NSObject

@property (nonatomic,assign) NSInteger mediaId; //新闻id
@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,copy) NSString *picture; //媒体新闻图片地址
@property (nonatomic,copy) NSString *descrip; //新闻简述
@property (nonatomic,copy) NSString *link;  //点击后获得的新闻地址
@property (nonatomic,copy) NSString *created;  //发布日期

@end
