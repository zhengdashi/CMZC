//
//  CMTradeToolModes.h
//  CMZC
//
//  Created by 财猫 on 16/4/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMTradeToolModes : NSObject

@property (nonatomic,copy) NSString *code; //交易代码
@property (nonatomic,copy) NSString *name; //名称
@property (nonatomic,copy) NSString *price; //价格
@property (nonatomic,copy) NSString *number; //数量

@end
