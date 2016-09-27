//
//  CMOptionTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  选项

#import <UIKit/UIKit.h>

@protocol CMOptionTableViewCellDelegate <NSObject>
/**
 *  传过去but的tag以便于区分
 *
 *  @param btTag but的tag
 */
- (void)cm_optionTableViewCellButTag:(NSInteger)btTag;

@end


@interface CMOptionTableViewCell : UITableViewCell

@property (assign, nonatomic) id<CMOptionTableViewCellDelegate>delegate;

@end
