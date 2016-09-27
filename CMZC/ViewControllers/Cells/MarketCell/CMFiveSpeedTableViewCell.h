//
//  CMFiveSpeedTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/4/19.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMFiveSpeedTableViewCell : UITableViewCell

//这个地方完全是为了测试。数据没有来，测试测了。就做出效果来
- (void)cm_fiveSpeedIndex:(NSInteger)index contentArr:(NSArray *)arr;

+ (instancetype)cell;

@end
