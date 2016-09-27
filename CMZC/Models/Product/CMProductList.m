//
//  CMProductList.m
//  CMZC
//
//  Created by 财猫 on 16/4/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//




#import "CMProductList.h"


@implementation CMLeadinvestor


@end


@implementation CMProductList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productId":@"id",
             @"descri":@"description",
             @"typeName":@"typename"
             };
}



@end


