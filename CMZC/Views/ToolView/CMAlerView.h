//
//  CMAlerView.h
//  CMZC
//
//  Created by 财猫 on 16/4/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTradeToolModes.h"

@class CMAlerView;
@protocol CMAlerViewDelegate <NSObject>
/**
 *  点击取消  确定按钮调用的delegate
 *
 *  @param alerView sel
 *  @param btnIndex btn  tag
 */
- (void)cm_cmalerView:(CMAlerView *)alerView willDismissWithButtonIndex:(NSInteger)btnIndex;

@end

@interface CMAlerView : UIView

@property (nonatomic,assign) id<CMAlerViewDelegate>delegate;

/**
 *  alerview的初始化方法
 *
 *  @param frame      你懂得
 *  @param title      tit标题
 *  @param certain    确定按钮的名字
 *  @param delegateVC delegate 的vc
 *  @param trade      类
 */
- (instancetype)initWithFrame:(CGRect)frame
                    titleName:(NSString *)title
                      certain:(NSString *)certain
                     delegate:(id)delegateVC
                    tradeTool:(CMTradeToolModes *)trade ;

- (void)show;

@end
