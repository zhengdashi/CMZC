//
//  UIStoryboard+Extensions.h
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * myMessage
 */
extern NSString *const idMessageViewController;


@interface UIStoryboard (Extensions)

/**
 *  主storyboard
 */
+ (UIStoryboard *)mainStoryboard;

/**
 *  登录的界面
 */
+ (UIStoryboard *)loginStoryboard;

/**
 *  根据storyboard ID来找到所需要的vc
 *
 *  @param identifier storyboard id
 */
- (UIViewController *)viewControllerWithId:(NSString *)identifier;
@end
