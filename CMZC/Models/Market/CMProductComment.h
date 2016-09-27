//
//  CMProductComment.h
//  CMZC
//
//  Created by 财猫 on 16/6/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMProductComment : NSObject

@property (nonatomic,copy) NSString *title;
@property (strong, nonatomic) NSString *created; //时间
@property (strong, nonatomic) NSString *content; //内容

@end
