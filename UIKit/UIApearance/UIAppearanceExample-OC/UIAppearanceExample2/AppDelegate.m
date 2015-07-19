//
//  AppDelegate.m
//  UIAppearanceExample2
//
//  Created by southpeak on 15/7/18.
//  Copyright © 2015年 iosdev. All rights reserved.
//

#import "AppDelegate.h"
#import "RoundLabel.h"
#import "RuntimeExamine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setAppearance];
    
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

- (void)setAppearance {
    
    UIColor *color = [UIColor colorWithRed:104.0/255.0 green:224.0/255.0 blue:231.0/255.0 alpha:1.0f];
    
    NSDictionary *textAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:15.0],
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    
    [[UINavigationBar appearance] setBarTintColor:color];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    
    [UIActivityIndicatorView appearance].color = color;
    
    [UILabel appearance].textColor = color;
    
    [UIButton appearance].backgroundColor = color;
    [[UIButton appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[ [UINavigationBar class], [UIToolbar class] ]];
//    [barButtonItemAppearance setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    [RoundLabel appearance].cornerRadius = 5.0f;
    [RoundLabel appearance].borderColor = color;
    [RoundLabel appearance].borderWidth = 1.0f;
    
    [RuntimeExamine examineUIAppearance];
    [RuntimeExamine examineAppearanceRecorder];
}

@end
