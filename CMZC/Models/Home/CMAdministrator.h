//
//  CMAdministrator.h
//  CMZC
//
//  Created by 郑浩然 on 17/1/4.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMAdministrator : NSObject

@property (nonatomic,copy) NSString *adminId; //id
@property (nonatomic,copy) NSString *title; // 标题
@property (nonatomic,copy) NSString *imageUrl; //头像地址
@property (nonatomic,copy) NSString *name; //名字
@property (nonatomic,copy) NSString *type; //标签
@property (nonatomic,copy) NSString *data1; //左边数据
@property (nonatomic,copy) NSString *data2; //右边数据
@end
