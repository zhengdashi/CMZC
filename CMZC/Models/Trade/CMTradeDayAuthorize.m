//
//  CMTradeDayAuthorize.m
//  CMZC
//
//  Created by 财猫 on 16/4/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeDayAuthorize.h"

@implementation CMTradeDayAuthorize


- (NSString *)condition {
    switch (_status) {
        case 1:
            return @"未成交";
        case 2:
            return @"已成交";
        case 3:
            return @"部分成交";
        case 4:
            return @"部分撤单";
            break;
        case 5:
            return @"撤单";
            break;
        default:
            return @"场内废单";
            break;
    }
}
- (NSString *)selldirection {
    switch (_direction) {
        case 1:
            return @"买入";
            break;
        default:
            return @"卖出";
            break;
    }
}


@end
