//
//  CMMediaNews.m
//  CMZC
//
//  Created by 财猫 on 16/3/21.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMediaNews.h"

@implementation CMMediaNews

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mediaId":@"id",
             @"descrip":@"description"
             };
}

@end
