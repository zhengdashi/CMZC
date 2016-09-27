//
//  CMDiscussTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易详情 评论

#import <UIKit/UIKit.h>
@class CMProductComment;
@interface CMDiscussTableViewCell : UITableViewCell


@property (strong, nonatomic) CMProductComment *notion;

+ (instancetype)cell;

@end
