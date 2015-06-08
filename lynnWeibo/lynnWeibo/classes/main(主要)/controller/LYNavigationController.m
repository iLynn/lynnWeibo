//
//  LYNavigationController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYNavigationController.h"

@interface LYNavigationController ()

@end

@implementation LYNavigationController

/**
 *  当第一次调用这个类的时候，此函数运行一次。将appearence放在这里设置，优化了内存
 */
+(void)initialize
{
    //设置UINavigationBar的主题
    [self setNavigationBarTheme];
    
    //设置UIBarButtonItem的主题
    [self setUIBarButtonTheme];
    
}

/**
 *  设置UINavigationBar的主题
 */
+ (void)setNavigationBarTheme
{
    UINavigationBar * barApperence = [UINavigationBar appearance];
    
    //设置文字属性
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = LYNavigationColor;
    dict[NSFontAttributeName] = LYNavigationFont;
    
    [barApperence setTitleTextAttributes:dict];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setUIBarButtonTheme
{
    //appearence一次设置，全局可用！
    
    //通过appearence对象设置整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem * itemAppearence = [UIBarButtonItem appearance];
    
    //设置普通状态下的文字属性
    NSMutableDictionary * normalDict = [NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [itemAppearence setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    
    //设置选中状态下的文字属性
    NSMutableDictionary * highlightedDict = [NSMutableDictionary dictionary];
    highlightedDict[NSForegroundColorAttributeName] = [UIColor redColor];
    highlightedDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [itemAppearence setTitleTextAttributes:highlightedDict forState:UIControlStateHighlighted];
    
    //设置不可用状态下的文字属性
    NSMutableDictionary * disableDict = [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [itemAppearence setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/**
 *  拦截所有push进来的子控制器
 *
 *  @param viewController 新的控制器
 *  @param animated       动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //不是navi的根（根是栈底的那个控制器），就隐藏底部tabbar导航
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //添加导航按钮：所有非根控制器（四大控制器），都会默认显示左右导航按钮如下。
        //不想使用如下按钮，可在自己vc的viewDidLoad里重新设置
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_back" andSelectedImageName:@"navigationbar_back_highlighted" andTarget:self andAction:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_more" andSelectedImageName:@"navigationbar_more_highlighted" andTarget:self andAction:@selector(more)];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    //此处self，指当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}

-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
