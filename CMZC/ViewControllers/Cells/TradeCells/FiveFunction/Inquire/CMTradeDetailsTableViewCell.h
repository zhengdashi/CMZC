//
//  CMTradeDetailsTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  交易详情cell

#import <UIKit/UIKit.h>

@interface CMTradeDetailsTableViewCell : UITableViewCell
/**
 *  传入所需要的数据
 *
 *  @param name    名字
 *  @param details 详情
 */
- (void)cm_tradeDetailsTitleName:(NSString *)name
                     detailsName:(NSString *)details;

@end
