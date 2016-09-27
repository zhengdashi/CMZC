//
//  CMRemoveTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/6/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CMMayRemove;

@interface CMRemoveTableViewCell : UITableViewCell

@property (strong, nonatomic) CMMayRemove *remove;

+ (instancetype)cell;

@end
