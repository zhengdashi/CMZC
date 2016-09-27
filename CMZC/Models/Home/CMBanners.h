//
//  CMBanners.h
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  轮播图models

#import <Foundation/Foundation.h>

@interface CMBanners : NSObject
@property (nonatomic,assign) NSInteger bannerId; //图片id
@property (nonatomic,copy) NSString *pictureurl;//图片的url
@property (nonatomic,copy) NSString *link; //点击图片后的地址

@end
