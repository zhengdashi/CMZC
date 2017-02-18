//
//  CMReplyTableViewCell.h
//  CMZC
//
//  Created by 郑浩然 on 17/1/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTopicList.h"
#import "CMTopicReplies.h"

@class CMAnalystPoint;

@protocol CMReplyTableViewCellDelegate <NSObject>

/**
 点击发送了按钮

 @param topic
 */
- (void)cm_replyTableTopicList:(CMTopicList *)topic;

- (void)cm_replyTableLockMore:(CMTopicList *)topic;

@end


@interface CMReplyTableViewCell : UITableViewCell

@property (strong, nonatomic) CMAnalystPoint *analystPoint;

@property (strong, nonatomic) CMTopicList *topicList;

@property (strong, nonatomic) CMTopicReplies *topicReplies;

@property (strong, nonatomic) id<CMReplyTableViewCellDelegate>delegate;

@end
