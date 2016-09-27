//
//  CMTimer.h
//  CMZC
//
//  Created by 财猫 on 16/5/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CMTimerBlock)();

@interface CMTimer : NSObject

@property (nonatomic,copy) CMTimerBlock timerMinblock;
/**
 *  初始化一个定时器
 *
 *  @param inter 执行时间
 */
- (instancetype)initTimerInterval:(NSInteger)inter;
/**
 *  关闭定时器
 */
- (void)close;

@end
