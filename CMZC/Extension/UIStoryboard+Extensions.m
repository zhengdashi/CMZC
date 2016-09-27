//
//  UIStoryboard+Extensions.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "UIStoryboard+Extensions.h"

NSString *const idMessageViewController = @"idMessageViewController";


@implementation UIStoryboard (Extensions)
//主sb
+ (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

//登录sb
+ (UIStoryboard *)loginStoryboard {
    return [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

//得到索要找的vc
- (UIViewController *)viewControllerWithId:(NSString *)identifier {
    return [self instantiateViewControllerWithIdentifier:identifier];
}

@end
