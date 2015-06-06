//
//  LYTabBarController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYTabBarController.h"

//#define LYRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

@interface LYTabBarController ()

@end

@implementation LYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.选中时文字为橙色（渲染）
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //2.添加子控制器
    UITableViewController * home = [[UITableViewController alloc]init];
    [self addOneChildViewController:home withTitle:@"首页" andImageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    
    UITableViewController * message = [[UITableViewController alloc]init];
    [self addOneChildViewController:message withTitle:@"消息" andImageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    
    UITableViewController * discover = [[UITableViewController alloc]init];
    [self addOneChildViewController:discover withTitle:@"发现" andImageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    
    UITableViewController * profile = [[UITableViewController alloc]init];
    [self addOneChildViewController:profile withTitle:@"我" andImageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    
}


-(void)addOneChildViewController:(UIViewController *)childVC withTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName
{
    childVC.view.backgroundColor = LYRandomColor;
    
    //1.控制器的基础设置
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    //2.添加到tabbar控制器
    [self addChildViewController:childVC];
}

@end
