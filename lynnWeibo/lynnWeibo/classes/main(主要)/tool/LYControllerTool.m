//
//  LYControllerTool.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYControllerTool.h"
#import "LYTabBarController.h"
#import "LYIntroController.h"

@implementation LYControllerTool

+(void)chooseRootViewController
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    // 判断版本号（用__bridge桥接转换core foundation数据类型和foundation数据类型）
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        window.rootViewController = [[LYTabBarController alloc] init];
    }
    else
    {
        window.rootViewController = [[LYIntroController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}

@end
