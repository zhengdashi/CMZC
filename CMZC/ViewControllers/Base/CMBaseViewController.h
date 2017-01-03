//
//  CMBaseViewController.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBaseViewController : UIViewController

+ (UIViewController *)initByStoryboard;

- (void)showTabBarViewControllerType:(NSInteger)tabIndex;


@end
