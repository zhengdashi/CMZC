//
//  TitleView.h
//  Lecturer
//
//  Created by Qida on 14-3-27.
//  Copyright (c) 2014年 Qida. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>

@optional
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab;

@end

@interface TitleView : UIView

@property (nonatomic,assign) NSInteger selectBtnIndex;
- (void)setSelectTitleByIndex:(NSInteger)index andTitle:(NSString *)title;

- (void)addTab:(UIButton *)tab;

- (void)addTabWithoutSeparator:(UIButton *)tab;

- (void)setHairlineColor:(UIColor *)color;

//- (void)setSelectTitleByIndex:(int)index andTitle:(NSString *)title;

@property (nonatomic ,weak) id<TitleViewDelegate> delegate;

@end
