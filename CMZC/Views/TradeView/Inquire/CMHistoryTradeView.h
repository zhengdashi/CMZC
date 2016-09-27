//
//  CMHistoryTradeView.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  历史交易查询

#import <UIKit/UIKit.h>

@class CMTurnoverList;

@protocol CMHistoryTradeViewDelegate <NSObject>
/**
 *  这里应该传出一个类，这个类现在没数据，就先传一个index
 *
 *  @param index
 */
- (void)cm_historyTradeViewIndex:(CMTurnoverList *)turnover;

@end


@interface CMHistoryTradeView : UIView

@property (nonatomic,assign)id<CMHistoryTradeViewDelegate>delegate;

@end
