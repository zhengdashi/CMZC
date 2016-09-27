//
//  CMAppVersion.h
//  CMZC
//
//  Created by 财猫 on 16/5/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAppVersion : NSObject

@property (nonatomic,copy) NSString *version; //版本号
@property (nonatomic,copy) NSString *content; //更新内容
@property (nonatomic,copy) NSString *address; //下载地址

@end
