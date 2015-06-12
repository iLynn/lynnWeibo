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
#import "LYAccountTool.h"
#import "LYSinaAccount.h"
#import "LYHttpTool.h"
#import "LYUnreadStatusModel.h"
#import "MJExtension.h"


@interface LYTabBarController ()<LYTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) LYHomeTableController * home;
@property (nonatomic, weak) LYMessageTableController * message;
@property (nonatomic, weak) LYProfileTableController * profile;

@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;

@end

@implementation LYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    //1.添加子控制器
    [self addAllChildVCs];
    
    
    //2.不用系统自带的tabbar，改用自定义的
    LYTabBar * customTabBar = [[LYTabBar alloc] init];
    
    customTabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    customTabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
    
    //3.设置代理
    customTabBar.lydelegate = self;
    
    // 更换系统自带的tabbar：直接用KVC改掉了
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    
    //4.选中时文字为橙色（渲染）
    self.tabBar.tintColor = [UIColor orangeColor];
    
    
    //5.利用定时器获得用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


-(void)getUnreadCount
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    params[@"uid"] = [LYAccountTool account].uid;
    
    //2.发送请求
    [LYHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id responseObj) {
        // 字典转模型
        LYUnreadStatusModel * unread = [LYUnreadStatusModel objectWithKeyValues:responseObj];
        
        //1.首页
        if (unread.status == 0)
        {
            self.home.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unread.status];
        }
        
        //2.消息
        if (unread.messageCount == 0)
        {
            self.message.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unread.messageCount];
        }
        
        //3.粉丝
        if (unread.follower == 0)
        {
            self.profile.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unread.follower];
        }
        
        //在icon图标上显示所有的小数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = unread.totalCount;
        
        LYLog(@"所有未读信息%d条", unread.totalCount);
        
        
    } failure:^(NSError * error) {
        
        LYLog(@"获取未读信息失败 -- %@", error);
        
    }];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController * vc = [viewController.viewControllers firstObject];
    
    if ([vc isKindOfClass:[LYHomeTableController class]])
    {
        if (self.lastSelectedViewContoller == vc)
        {
            [self.home refresh:YES];
        }
        else
        {
            [self.home refresh:NO];
        }
    }
    
    self.lastSelectedViewContoller = vc;
}

-(void)addAllChildVCs
{
    LYHomeTableController * home = [[LYHomeTableController alloc]init];
    [self addOneChildViewController:home withTitle:@"首页" andImageName:@"tabbar_home" andSelectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewContoller = home;
    
    LYMessageTableController * message = [[LYMessageTableController alloc]init];
    [self addOneChildViewController:message withTitle:@"消息" andImageName:@"tabbar_message_center" andSelectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    LYDiscoverTableController * discover = [[LYDiscoverTableController alloc]init];
    [self addOneChildViewController:discover withTitle:@"发现" andImageName:@"tabbar_discover" andSelectedImageName:@"tabbar_discover_selected"];
    
    LYProfileTableController * profile = [[LYProfileTableController alloc]init];
    [self addOneChildViewController:profile withTitle:@"我" andImageName:@"tabbar_profile" andSelectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
    
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
