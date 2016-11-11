//
//  CMProgressView.h
//  CMZC
//
//  Created by 郑浩然 on 16/9/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMProgressView : UIView
@property (nonatomic, strong) UIColor *progressColor; // 进度条颜色 默认红色
@property (nonatomic, strong) UIColor *progressBackgroundColor; // 进度条背景色 默认灰色
@property (nonatomic, assign) CGFloat progressWidth; // 进度条宽度 默认3
@property (nonatomic, assign) float percent; //进度条进度 0-1
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIColor *labelbackgroundColor; //背景色 默认clearColor
@property (nonatomic, strong) UIColor *textColor; //字体颜色 默认黑色
@property (nonatomic, strong) UIFont *textFont; //的字体大小 默认15
@end
