//
//  CMTradeDetailView.h
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  五档  明细

#import <UIKit/UIKit.h>

@interface CMTradeDetailView : UIView
//产品代码
@property (nonatomic,copy) NSString *code;
/**
 *  明细请求
 */
- (void)detailBtnClick;
/**
 *  五档
 */
- (void)fiveSpeedBtnClick;

@end
