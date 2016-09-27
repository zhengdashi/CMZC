//
//  CMPingLTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  评论cell  用了个很low的名字。实在是想不起来了。顺手就写了

#import <UIKit/UIKit.h>

@class CMProductNotion;

@interface CMPingLTableViewCell : UITableViewCell

@property (strong, nonatomic) CMProductNotion *productComment;

@property (strong, nonatomic) NSArray *commDataArr;

+ (instancetype)cell;

@end
