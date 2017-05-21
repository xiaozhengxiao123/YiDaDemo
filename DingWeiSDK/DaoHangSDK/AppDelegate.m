//
//  AppDelegate.m
//  DaoHangSDK
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 yidahulian. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DanCiDingWeiViewController.h"
#import "DiTuChuangJian.h"
#import "DiTuJiePin.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//--------------------------------------------------------------------
    /*** 定位SDK ***/
    
    //持续定位和后台定位
//    self.window.rootViewController = [[ViewController alloc] init];
    
    //带逆地理编码的定位 与 不带逆地理编码的定位（单次定位）
//    self.window.rootViewController = [[DanCiDingWeiViewController alloc] init];
    
//--------------------------------------------------------------------
    /*** 3D地图SDK ***/
    
    //1.创建地图：显示地图，显示定位蓝点，显示室内地图，切换地图图层；
    //2.与地图交互：控件交互，手势交互，方法交互，地图截屏功能。
//    self.window.rootViewController = [[DiTuChuangJian alloc] init];
    
    //地图截屏功能
    self.window.rootViewController = [[DiTuJiePin alloc] init];
    
    

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

@end
