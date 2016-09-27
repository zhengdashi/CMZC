//
//  CMTrustTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  委托详情

#import <UIKit/UIKit.h>

@interface CMTrustTableViewCell : UITableViewCell
/**
 *  传入所需要的数据
 *
 *  @param name    名字
 *  @param details 详情
 */
- (void)cm_tradeDetailsTitleName:(NSString *)name
                     detailsName:(NSString *)details
                           index:(NSInteger)index;
@end
