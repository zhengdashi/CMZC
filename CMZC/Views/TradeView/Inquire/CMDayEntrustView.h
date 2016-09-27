//
//  CMDayEntrustView.h
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  当日委托

#import <UIKit/UIKit.h>
@class CMTradeDayAuthorize;

//这里应该传一个类。但是现在没有数据，先传一个过去。实验效果
typedef void(^CMDayEntrustViewBlock)(CMTradeDayAuthorize *sender);

@interface CMDayEntrustView : UIView

@property (nonatomic,copy)CMDayEntrustViewBlock dayEntrBlock;

@end
