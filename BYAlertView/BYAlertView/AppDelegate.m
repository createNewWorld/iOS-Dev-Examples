//
//  AppDelegate.m
//  BYAlertView
//
//  Created by ft on 16/8/17.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

//#import <weex/WeexSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    navc.navigationBar.translucent = NO;
    _window.rootViewController = navc;
    [self configeNavigationBarShowStyle];
    
 //   [WXAppConfiguration setAppGroup:@"cdfortis"];
 //   [WXAppConfiguration setAppName:@"微问诊"];
 //   [WXAppConfiguration setAppVersion:@"CFBundleShortVersionString"];
 //   [WXAppConfiguration setExternalUserAgent:@"cd"];
    
 //   [WXSDKEngine initSDKEnviroment];
    
    NSString *string = @"2016-12-30";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+0800"]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    NSDateFormatter *signFormatter = [[NSDateFormatter alloc] init];
    [signFormatter setDateFormat:@"M/dd/yyyy"];
    NSString *signDateStr = [signFormatter stringFromDate:date];
    NSLog(@"siginDateStr =%@",signDateStr);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)configeNavigationBarShowStyle
{
    //状态栏颜色 //需要先在Info.plist中设置UIViewControllerBasedStatusBarAppearance为NO
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    //左右按钮字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //将title的字体颜色设置为白色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
