//
//  CMNoticeModel.m
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNoticeModel.h"

@implementation CMNoticeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
            @"noticId":@"id",
            @"descri":@"description"
            };
}

@end
