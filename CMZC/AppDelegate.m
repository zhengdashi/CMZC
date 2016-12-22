//
//  AppDelegate.m
//  CMZC
//
//  Created by 财毛 on 16/3/1.
//  Copyright © 2016年 财毛. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"


#import "CMApp_Header.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shareDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:[UIColor cmThemeOrange]];
   
    //***********    调试登录
    
    
    //由于分享要真机。不然会出现错误。所哟，先注销掉。测试时在借助
   // [self umsocialData];
    
    //显示引导页
    [self showWelcome];
    
    //推送
    [self jpushService:launchOptions];
    
    
    return YES;
}

//程序将要进入后台的时候
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    if (CMIsLogin()) {
        
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//程序将要回复
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    // 当程序从后台将要重新回到前台时候调用
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if (CMIsLogin()) {
        
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//友盟
- (void)umsocialData {
    [UMSocialData setAppKey:kUMSocial_Appkey];
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:kUMSocial_QQAppId appKey:kUMSocail_QQAppKey url:kUMSocial_url];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:kUMSocial_WechatId appSecret:kUMSocial_wechatSecret url:kUMSocial_url];
    //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kUMSocial_sinaAppKey
                                              secret:kUMSocial_sinaAppSecret
                                         RedirectURL:kUMSocial_url];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    // Required 注册要处理的远程通知类型
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@" %@",[userInfo description]);
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
     NSMutableArray *contentArr = [NSMutableArray array];
    [contentArr addObject:content];
    NSArray *alertArr = GetDataFromNSUserDefaults(@"alertArr");
    if (alertArr.count > 0) {
        for (NSString *alert in alertArr) {
            [contentArr addObject:alert];
        }
    }
    SaveDataToNSUserDefaults(contentArr, @"alertArr");
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo]; //处理收到的 APNs 消息
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With 《，Error: %@", error);
}

- (void)jpushService:(NSDictionary *)launchOptions {
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:@"059c7efbd0eab9d7160a5761" channel:nil apsForProduction:NO];
    
    
   
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    
}
- (void)networkDidMessage:(NSNotification *)notification {
    
}

/**
 *  显示引导页
 */
- (void)showWelcome {
    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *versionKey = [NSString stringWithFormat:@"%@_isFirstRun",localVersion];
    BOOL isFirstRunThisVersion = [GetDataFromNSUserDefaults(versionKey) boolValue];
    if (!isFirstRunThisVersion) {
        self.viewController = self.window.rootViewController;
        self.window.rootViewController = [[UIStoryboard loginStoryboard] viewControllerWithId:@"CMGuideViewController"];
        SaveDataToNSUserDefaults([NSNumber numberWithBool:YES], versionKey);
    }
    
}
#pragma mark - 开启定时器 刷新token


@end
