//
//  CMTabBarViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTabBarViewController.h"
#import "CMLoginViewController.h"

@interface CMTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation CMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 49)];
    [self.tabBar insertSubview:tabBarView atIndex:0];
    self.tabBar.opaque = YES;
    self.delegate = self;
    [tabBarView setBackgroundColor:[UIColor cmtabBarGreyColor]];
    
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]) //assuming the index of uinavigationcontroller is 2
    {
        if (CMIsLogin()) {
            return YES;
        } else {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTabBarIndex) name:@"loginWin" object:nil];
            CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
            [self presentViewController:loginVC animated:YES completion:nil];
            return  NO;
        }
    } else if (viewController == [tabBarController.viewControllers objectAtIndex:0]) {
        NSArray *contArr = self.navigationController.viewControllers;
        NSLog(@"%ld",(unsigned long)contArr.count);
        return YES;
    } else {
        return YES;
    }
}
- (void) presentTabBarIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 3;
}
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
