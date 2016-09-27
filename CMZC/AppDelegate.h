//
//  AppDelegate.h
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 财毛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

+ (AppDelegate *)shareDelegate;

@end

