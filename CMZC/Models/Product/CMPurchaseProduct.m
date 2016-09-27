//
//  CMPurchaseProduct.m
//  CMZC
//
//  Created by 财猫 on 16/4/18.
//  Copyright © 2016年 郑浩然. All rights reserved.
//
#define kGrowthValue(msg) [self.growthvalue isEqualToString:msg]
#define kAttributedStr @"AAAAA"

#import "CMPurchaseProduct.h"
#import "NSMutableAttributedString+AttributedString.h"


@implementation CMPurchaseProduct
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productId":@"id",
             @"descri":@"description",
             };
}
- (NSMutableAttributedString *)attributed {
    
    if (kGrowthValue(@"0")) {
        return [self mutableAttributeLenRange:0];
    } else if (kGrowthValue(@"1")) {
        return [self mutableAttributeLenRange:1];
    } else if (kGrowthValue(@"2")) {
        return [self mutableAttributeLenRange:2];
    } else if (kGrowthValue(@"3")) {
        return [self mutableAttributeLenRange:3];
    } else if (kGrowthValue(@"4")){
        return [self mutableAttributeLenRange:4];
    } else {
        return [self mutableAttributeLenRange:5];
    }
    
    
}

- (BOOL)isNextPage {
    if ([self.status isEqualToString:@"立即申购"]) {
        return YES;
    } else if ([self.status isEqualToString:@"路演中"]) {
        return YES;
    } else {
        return NO;
    }
    
    
    
}
- (NSMutableAttributedString *)mutableAttributeLenRange:(NSInteger)len {
    return [NSMutableAttributedString cm_mutableAttributedString:kAttributedStr
                                                       valueFont:13
                                                      valueColor:[UIColor cmThemeOrange]
                                                        locRange:0
                                                        lenRange:len];
}

@end
