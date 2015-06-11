//
//  AppDelegate.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "AppDelegate.h"
#import "LYOAuthSinaController.h"
#import "LYControllerTool.h"
#import "LYAccountTool.h"
#import "LYSinaAccount.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD+LY.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.设置窗口可见
    [self.window makeKeyAndVisible];
    
    //3.设置窗口的根控制器
    LYSinaAccount * account = [LYAccountTool account];
    
    //曾经登录过：判断版本情况，选择跟控制器
    if (account)
    {
        [LYControllerTool chooseRootViewController];
    }
    //没有登录过：先做授权
    else
    {
        self.window.rootViewController = [[LYOAuthSinaController alloc] init];
    }
    
    //4.监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                LYLog(@"没有网络(断网)");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                LYLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                LYLog(@"WIFI");
                break;
        }
    }];
    
    // 开始监控
    [mgr startMonitoring];
    
    
    return YES;
    
}

/**
 *  当收到内存警告时，清除图片
 *
 *  @param application <#application description#>
 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //1.清除图片
    [[SDImageCache sharedImageCache] clearMemory];
    
    //2.停止正在下载的图片的操作
    [[SDWebImageManager sharedManager] cancelAll];
    
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
