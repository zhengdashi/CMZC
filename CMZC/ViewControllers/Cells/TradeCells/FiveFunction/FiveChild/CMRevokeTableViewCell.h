//
//  CMRevokeTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  撤单tableview cell

#import <UIKit/UIKit.h>
#import "CMTradeDayAuthorize.h"

//@class CMMayRemove;
@interface CMRevokeTableViewCell : UITableViewCell

@property (strong, nonatomic) CMTradeDayAuthorize *authorize;


+ (instancetype)cell;

@end
