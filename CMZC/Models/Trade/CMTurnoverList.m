//
//  CMTurnoverList.m
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTurnoverList.h"

@implementation CMTurnoverList

- (NSString *)cater {
    switch (self.direction) {
        case 1:
            return @"买入";
            break;
        case 2:
            return @"卖出";
            break;
        default:
            return nil;
            break;
    }
    
}

@end
