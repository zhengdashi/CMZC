//
//  CMDayTradeTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  当日查询

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DayTradeTableType){
    DayTradeTableTypeDay, //今日
    DayTradeTableTypeHistory //历史
};

#import "CMTurnoverList.h"


@interface CMDayTradeTableViewCell : UITableViewCell

@property (strong, nonatomic) CMTurnoverList *turnover;

- (void)cm_dayTradeTurnoverList:(CMTurnoverList *)turnover tradeTableType:(DayTradeTableType)type;

+ (instancetype)cell;

@end
