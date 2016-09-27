//
//  CMSubscribeGuideTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMSubscribeGuideTableViewCell : UITableViewCell
/**
 *  传入数据展示
 *
 *  @param titleName 名字
 *  @param details   详情
 */
- (void)cm_subscribeGuideTitleName:(NSString *)titleName
                        detailsStr:(NSString *)details;


@end
