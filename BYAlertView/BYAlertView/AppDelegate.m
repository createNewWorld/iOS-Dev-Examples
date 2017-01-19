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
    
   
    
    NSString *urlStr = @"http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg";
//
    NSURL *url = [NSURL URLWithString:urlStr];
    
//    NSError *error = nil;
//    NSData *imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
//    
//    NSLog(@"imageData = %@, %@", imageData, error);
//    
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//        NSLog(@"imageData2 = %@, %@", imageData, connectionError);
//    }];
//    
// 
//    
//    NSMutableURLRequest *imageRequest = [NSMutableURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imageRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"response = %@ , location = %@, error = %@", response, location, error);
//        
//        //6.处理文件
////        //6.1 获得文件的名称
////        NSString *fileName = response.suggestedFilename;
////        
////        //6.2 写路径到磁盘+拼接文件的全路径
////        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
////        
////        //6.3 执行剪切操作
////        
////        NSLog(@"%@",fullPath);
//        
//    }];
//    
//    [task resume];
    
    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:url];
    //创建 http hear 请求头
    NSString *boundary = @"1024000";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", boundary];
    [uploadRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [uploadRequest setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    /**
     *  上传文件格式
     *  beginBoundary
     *  Content-Disposition:form-data;name="<服务器知道你的名字>";filename="<服务器保存的文件名>"
     *  Content-Type:application/zip //根据不同的文件类型选择不同的值
     *  <空行>
     *  <二进制数据>
     *  endBoundary
     */
    
//    范例：
//    
//    ----KenApp299912318
//    Content-Disposition: form-data; name="<服务器端需要知道的名字>"; filename="<服务器端这个传上来的文件名>"
//    Content-Type: application/zip --根据不同的文件类型选择不同的值
//    
//    <空行>
//    
//    <二进制数据>
//    
//    ----KenApp299912318--
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:uploadRequest
                                                               fromData:[self createDataForRequestHTTPBodyForSource]
                                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                          NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                                          NSLog(@"response = %@", response);
                                                          if([error isEqual:[NSNull class]] || error == nil){
                                                              NSLog(@"上传成功");
                                                          }else{
                                                              NSLog(@"上传失败");
                                                          }
                                                      }];
    [uploadTask resume];
    

    
    
    return YES;
}

- (NSData *)createDataForRequestHTTPBodyForSource
{
    NSMutableString *bodyHead = [[NSMutableString alloc] init];
    NSMutableData *data = [NSMutableData new];
    
    NSURL *url = [NSURL URLWithString:@"http://baidu.com/download/imageName.jpeg"];
    NSString *fileName = [url lastPathComponent];
    NSString *name = @"uploadFile";
    
    NSData *fileContent = [NSData dataWithContentsOfURL:url];
    NSString *beginBoundary = @"----KenApp299912318";
    [bodyHead appendString:beginBoundary];
    [bodyHead appendFormat:@"-------"];
    //数据类型描述
    [bodyHead appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\r\n",name,fileName];
    [bodyHead appendFormat:@"Content-Type: application/zip\r\n\r\n"];
    //内容
    [data appendData:[bodyHead dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:fileContent];
    NSString *endBoundary = @"KenApp299912318----";
    [data appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
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
