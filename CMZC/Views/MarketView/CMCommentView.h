//
//  CMCommentView.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  评论

#import <UIKit/UIKit.h>


@class CMProductNotion;

@protocol CMCommentDelegate  <NSObject>
/**
 *  广告
 *
 *  @param notint 公告id
 */
- (void)cm_commentViewNotintId:(NSInteger)notint;

@end

@interface CMCommentView : UIView

@property (strong, nonatomic) NSArray *commDataArr;

@property (nonatomic,assign) id<CMCommentDelegate>delegate;

@end
