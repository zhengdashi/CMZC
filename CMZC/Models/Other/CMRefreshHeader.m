//
//  CMRefreshHeader.m
//  CMZC
//
//  Created by 财猫 on 16/6/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRefreshHeader.h"

@implementation CMRefreshHeader
- (void)prepare {
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=2; i++) {
        UIImage *image = [UIImage imageNamed:@"logo_anim_01"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=29; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"logo_anim_0%lu", (unsigned long)i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    
}

@end
