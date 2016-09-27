//
//  CMSubscribeTitleView.h
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  申购 头view

#import <UIKit/UIKit.h>

typedef void(^CMSubscribeTitleBlock)(NSInteger index);

@interface CMSubscribeTitleView : UIView

@property (nonatomic,copy)CMSubscribeTitleBlock titleBlock;

@end
