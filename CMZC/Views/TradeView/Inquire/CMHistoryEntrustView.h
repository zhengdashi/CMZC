//
//  CMHistoryEntrustView.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  历史委托

#import <UIKit/UIKit.h>
@class CMTradeDayAuthorize;

//这里应该传一个类。但是现在没有数据，先传一个过去。实验效果
typedef void(^CMHistoryEntrustViewBlock)(CMTradeDayAuthorize *sender);

@interface CMHistoryEntrustView : UIView

@property (nonatomic,copy)CMHistoryEntrustViewBlock historyEntrustBlock;

@end
