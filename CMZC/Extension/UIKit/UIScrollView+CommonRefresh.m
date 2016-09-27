//
//  UIScrollView+CommonRefresh.m
//  QDCLM
//
//  Created by Zheng on 16/1/11.
//  Copyright © 2016年 深圳企大信息技术有限公司. All rights reserved.
//

#import "UIScrollView+CommonRefresh.h"
#import "CMRefreshHeader.h"


@implementation UIScrollView (CommonRefresh)

- (void)addHeaderWithFinishBlock:(void (^)())finishBlock {
    if (finishBlock) {
        //CMRefreshHeader *header = [CMRefreshHeader headerWithRefreshingBlock:finishBlock];
        
        self.mj_header = [CMRefreshHeader headerWithRefreshingBlock:finishBlock];
    }
}

- (void)addFooterWithFinishBlock:(void (^)())footFinishBlock {
    if (footFinishBlock) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:footFinishBlock];
    }
}

- (void)beginHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)beginFooterRefreshing {
    [self.mj_footer beginRefreshing];
}

- (void)stopHeaderRefreshing {
    [self.mj_header endRefreshing];
}

- (void)stopFooterRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)endRefresh {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)showHeader {
    self.mj_header.hidden = NO;
}

- (void)hideHeader {
    self.mj_header.hidden = YES;
}

- (void)showFooter {
    self.mj_footer.hidden = NO;
}

- (void)hideFooter {
    self.mj_footer.hidden = YES;
}

- (void)noMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}
@end
