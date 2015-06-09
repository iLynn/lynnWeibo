//
//  LYHomeTableController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYHomeTableController.h"
#import "LYTitleButton.h"
#import "LYPopMenuView.h"
#import "AFHTTPRequestOperationManager.h"
#import "LYSinaAccount.h"
#import "LYAccountTool.h"
#import "MBProgressHUD+LY.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "LYWeiboStatus.h"
#import "LYStatusUser.h"


@interface LYHomeTableController ()<LYPopMenuViewDelegate>

/**
 *  微博数组(存放着所有的微博数据)
 */
@property (nonatomic, strong) NSArray * statuses;

@end

@implementation LYHomeTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LYLog(@"LYHomeTableController--viewDidLoad");
    
    //1.添加导航
    [self setUpNavigationBar];
    
    //2.加载数据
    [self loadNewStatus];
    
}

-(void)loadNewStatus
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数：主要是要access_token
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;;

    
    // 3.发送GET请求
    NSString * getUrlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json"];
    [manager GET:getUrlStr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        LYLog(@"请求成功--%@", responseObject);
        
        // 微博字典数组
        NSArray *statusDictArray = responseObject[@"statuses"];
        
        // 使用MJExtension，快速将微博字典数组 转换成 微博模型数组
        self.statuses = [LYWeiboStatus objectArrayWithKeyValuesArray:statusDictArray];
        
        //一定要reloadData，数据才会加载到页面
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        LYLog(@"请求失败--%@", error);
    }];

}

/**
 *  添加导航栏，并响应导航的数据
 */
-(void)setUpNavigationBar
{
    //1.添加左右两边的导航按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_friendsearch" andSelectedImageName:@"navigationbar_friendsearch_highlighted" andTarget:self andAction:@selector(searchFriend)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_pop" andSelectedImageName:@"navigationbar_pop_highlighted" andTarget:self andAction:@selector(pop)];
    
    
    //2.添加中间的导航标题
    LYTitleButton * titleView = [LYTitleButton titleButton];
    //[titleView setBackgroundImage:[UIImage resizedImage:@""] forState:UIControlStateHighlighted];
    
    [titleView setTitle:@"首页" forState:UIControlStateNormal];
    
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    titleView.width = 100;
    titleView.height = 35;
    
    //3.监听标题的点击事件
    [titleView addTarget:self action:@selector(titleButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleView;
    
}

-(void)titleButtonTouch:(LYTitleButton *)titleView
{
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor lightGrayColor];
    
    LYPopMenuView * menuView = [[LYPopMenuView alloc] initWithContentView:button];
    menuView.delegate = self;
    menuView.dimBackground = YES;
    menuView.arrowPosition = LYPopMenuViewArrowPositionCenter;
    [menuView showViewInRect:CGRectMake(self.view.width/2 - 100, 64, 200, 300)];
    
}

-(void)searchFriend
{
    LYLog(@"%s", __func__);
}

-(void)pop
{
    LYLog(@"%s", __func__);
}


#pragma mark - 自定义弹出menuView的代理方法

- (void)popMenuViewDidDismissed:(LYPopMenuView *)popMenuView
{
    LYTitleButton * titleButton = (LYTitleButton *)self.navigationItem.titleView;
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    // 取出这行对应的微博模型
    LYWeiboStatus * status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 取出用户模型
    LYStatusUser * user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 下载头像
    NSString *imageUrlStr = user.profile_image_url;
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * newVC = [[UIViewController alloc] init];
    newVC.view.backgroundColor = LYRandomColor;
    newVC.title = @"newVC";
    
    //LYHomeTableController是LYNavigationController的rootViewController，所以它可以使用nav的push功能进行页面跳转
    [self.navigationController pushViewController:newVC animated:YES];
    
}


@end
