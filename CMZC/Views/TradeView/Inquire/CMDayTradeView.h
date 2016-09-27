//
//  CMDayTradeView.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  当日查询

#import <UIKit/UIKit.h>

@class CMTurnoverList;

@protocol CMDayTradeViewDelegate <NSObject>
/**
 *  这里应该传出一个类，这个类现在没数据，就先传一个index
 *
 *  @param index
 */
- (void)cm_dayTradeViewIndex:(CMTurnoverList *)turnover;

@end


@interface CMDayTradeView : UIView

@property (nonatomic,assign)id<CMDayTradeViewDelegate>delegate;

@end
