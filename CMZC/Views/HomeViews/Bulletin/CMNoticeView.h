//
//  CMNoticeView.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  公告

#import <UIKit/UIKit.h>

@class  CMNoticeModel;

@protocol CMNoticeViewDeleagte <NSObject>
/**
 *  c传入公告的类
 *
 *  @param webURL webRUL
 */
- (void)cm_noticeViewSendNoticeModel:(CMNoticeModel *)notice;

@end


@interface CMNoticeView : UIView

@property (nonatomic,assign)id<CMNoticeViewDeleagte>delegate;

@end
