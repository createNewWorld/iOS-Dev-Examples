//
//  AppDelegate.swift
//  UIApearanceExample
//
//  Created by southpeak on 15/7/14.
//  Copyright © 2015年 iosdev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setAppearance()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setAppearance() {
        
        let color = UIColor(red: 104.0/255.0, green: 224.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        
        let textAttribute = [
            NSFontAttributeName: UIFont.systemFontOfSize(15.0),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().titleTextAttributes = textAttribute
        
        UIBarButtonItem.appearance().setTitleTextAttributes(textAttribute, forState: .Normal)
        
        // 此处会崩溃，提示EXC_BAD_ACCESS
        //        let barButtonItemAppearance = UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UINavigationBar.self, UIToolbar.self])
        //
        //        let attributes = [
        //            NSFontAttributeName: UIFont.systemFontOfSize(13.0),
        //            NSForegroundColorAttributeName: UIColor.whiteColor()
        //        ]
        //
        //        barButtonItemAppearance.setTitleTextAttributes(attributes, forState: .Normal)
        
        UIActivityIndicatorView.appearance().color = color
        
        UILabel.appearance().textColor = color;
        
        UIButton.appearance().backgroundColor = color
        UIButton.appearance().setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        RoundLabel.appearance().setBorderColor(color)
        RoundLabel.appearance().setBorderWidth(1.0)
        RoundLabel.appearance().setCornerRadius(3.0)
    }
}

