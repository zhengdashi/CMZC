//
//  CMMediaOrNoticeTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  公告和媒体的cell

#import <UIKit/UIKit.h>
#import "CMNoticeModel.h"



@interface CMMediaOrNoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//名字
@property (weak, nonatomic) IBOutlet UILabel *dateLab;//时间

@property (strong, nonatomic) CMNoticeModel *notice; //公告

@end
