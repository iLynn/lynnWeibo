//
//  LYTabBarController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYTabBarController.h"
#import "LYNavigationController.h"
#import "LYHomeTableController.h"
#import "LYMessageTableController.h"
#import "LYDiscoverTableController.h"
#import "LYProfileTableController.h"
#import "LYTabBar.h"
#import "LYWriteViewController.h"


@interface LYTabBarController ()<LYTabBarDelegate>

@end

@implementation LYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.添加子控制器
    LYHomeTableController * home = [[LYHomeTableController alloc]init];
    [self addOneChildViewController:home withTitle:@"首页" andImageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    
    LYMessageTableController * message = [[LYMessageTableController alloc]init];
    [self addOneChildViewController:message withTitle:@"消息" andImageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    
    LYDiscoverTableController * discover = [[LYDiscoverTableController alloc]init];
    [self addOneChildViewController:discover withTitle:@"发现" andImageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    
    LYProfileTableController * profile = [[LYProfileTableController alloc]init];
    [self addOneChildViewController:profile withTitle:@"我" andImageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    
    
    //2.不用系统自带的tabbar，改用自定义的
    LYTabBar * customTabBar = [[LYTabBar alloc] init];
    customTabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    customTabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
    
    //4.设置代理
    customTabBar.lydelegate = self;
    
    // 更换系统自带的tabbar：直接用KVC改掉了
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    
    //3.选中时文字为橙色（渲染）
    self.tabBar.tintColor = [UIColor orangeColor];

    
}


-(void)addOneChildViewController:(UIViewController *)childVC withTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName
{
    //此处设置颜色，则childVC.view会执行，那么对应的vc就会viewDidLoad，相对而言早了一点
    //childVC.view.backgroundColor = LYRandomColor;
    
    //1.控制器的基础设置
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //2.做个navigationBarController
    childVC.navigationItem.title = title;
    LYNavigationController * navC = [[LYNavigationController alloc]initWithRootViewController:childVC];
    
    //2.添加到tabbar控制器
    [self addChildViewController:navC];
    
}

#pragma mark - 自定义tabbar的代理方法

-(void)tabBarDidClickPlusButton:(LYTabBar *)tabBar
{
    LYWriteViewController * write = [[LYWriteViewController alloc]init];
    LYNavigationController * navC = [[LYNavigationController alloc]initWithRootViewController:write];
    
    [self presentViewController:navC animated:YES completion:nil];
}

@end
