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

@interface LYHomeTableController ()<LYPopMenuViewDelegate>

@end

@implementation LYHomeTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LYLog(@"LYHomeTableController--viewDidLoad");
    
    //1.添加左右两边的导航按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_friendsearch" andSelectedImageName:@"navigationbar_friendsearch_highlighted" andTarget:self andAction:@selector(searchFriend)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_pop" andSelectedImageName:@"navigationbar_pop_highlighted" andTarget:self andAction:@selector(pop)];
    
    
    //2.添加中间的导航标题
    LYTitleButton * titleView = [LYTitleButton titleButton];
    //[titleView setBackgroundImage:[UIImage resizedImage:@"more"] forState:UIControlStateHighlighted];
    
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Home -- line:%ld", (long)indexPath.row];
    
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
