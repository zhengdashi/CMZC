//
//  CLMNotDataView.h
//  UIErrorView
//
//  Created by Zheng on 16/1/7.
//  Copyright © 2016年 zhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLMNotDataView;
@protocol CLMNotDataViewDelegate <NSObject>
//- (void)clm_ClickJumpButton:(CLMNotDataView *)notDataView;//
- (void)notDataViewDidClicked;
@end


@interface CLMNotDataView : UIView
//图片的样式 
@property (copy, nonatomic) NSString *imageNameStr;
//提示语文字
@property (copy, nonatomic) NSString *markedWordsStr;
//按钮
@property (strong, nonatomic) UIButton *optionBut;
//按钮图片
@property (copy, nonatomic) NSString *optionStr;
//跳转按钮
@property (strong, nonatomic) UIButton *skipBut;

@property (weak, nonatomic) id<CLMNotDataViewDelegate>delegate;

- (void)imageViewImageName:(NSString *)imageName markedWordsStr:(NSString *)wordsStr optionImageStr:(NSString *)optionstr;
//删除view
- (void)dismiss;

@end
