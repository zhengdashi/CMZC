//
//  CMMoneyViewController.h
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//  新手指引，赚钱秘籍，

#import "CMBaseViewController.h"

@interface CMMoneyViewController : CMBaseViewController

@property (nonatomic,copy) NSString *titName;

/**
 *  传入需要的数据
 *
 *  @param title  标题名字
 *  @param name   图片名字
 *  @param height 图片高度
 */
- (void)cm_moneyViewTitleName:(NSString *)title
              bgImageViewName:(NSString *)name
                  imageHeight:(CGFloat)height;

@end
