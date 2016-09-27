//
//  UIScrollView+CommonRefresh.h
//  QDCLM
//
//  Created by Zheng on 16/1/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CommonRefresh)

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithFinishBlock:(void (^)())finishBlock;


/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithFinishBlock:(void (^)())finishBlock;

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)beginHeaderRefreshing;

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)beginFooterRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)stopHeaderRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)stopFooterRefreshing;

/**
 *  结束刷新
 */
- (void)endRefresh;

/**
 *  显示下拉刷新头部控件
 */
- (void)showHeader;

/**
 *  隐藏下拉刷新头部控件
 */
- (void)hideHeader;

/**
 *  显示上拉刷新尾部控件
 */
- (void)showFooter;

/**
 *  隐藏上拉刷新尾部控件
 */
- (void)hideFooter;

/**
 *  提示没有更多的数据
 */
- (void)noMoreData;

/**
 *  消除没有更多数据的提示
 */
- (void)resetNoMoreData;
@end
