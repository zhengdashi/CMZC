//
//  CMProductNotion.h
//  CMZC
//
//  Created by 财猫 on 16/6/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMProductNotion : NSObject

@property (nonatomic,assign) NSInteger notionId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descri;
@property (strong, nonatomic) NSString *created;

@end
