//
//  CMProductDetails.m
//  CMZC
//
//  Created by 郑浩然 on 16/10/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMProductDetails.h"

@implementation CMProductDetails

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"productId":@"id",
             @"descri":@"description",
             @"typeName":@"typename",
             
             };
}

@end
