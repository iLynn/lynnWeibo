//
//  LYHomeTableController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYHomeTableController.h"

@interface LYHomeTableController ()

@end

@implementation LYHomeTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_friendsearch" andSelectedImageName:@"navigationbar_friendsearch_highlighted" andTarget:self andAction:@selector(searchFriend)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_pop" andSelectedImageName:@"navigationbar_pop_highlighted" andTarget:self andAction:@selector(pop)];
    
    
    LYLog(@"LYHomeTableController--viewDidLoad");
    
}

-(void)searchFriend
{
    LYLog(@"%s", __func__);
}

-(void)pop
{
    LYLog(@"%s", __func__);
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
