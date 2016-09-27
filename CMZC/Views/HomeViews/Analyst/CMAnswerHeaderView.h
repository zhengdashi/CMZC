//
//  CMAnswerHeaderView.h
//  CMZC
//
//  Created by 财猫 on 16/3/22.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMAnalystAnswer.h"

@protocol CMAnswerHeaderViewDelegate <NSObject>

/**
 *  传一个问题的id
 *
 *  @param topicId 问题的id
 */
- (void)cm_answerHeaderViewTopicId:(NSInteger)topicId indexPath:(NSInteger)index;

@end

@interface CMAnswerHeaderView : UIView

@property (nonatomic,assign)id<CMAnswerHeaderViewDelegate>delegate;

@property (strong, nonatomic) CMAnalystAnswer *analyst;

@property (nonatomic,assign) NSInteger index;

@end
