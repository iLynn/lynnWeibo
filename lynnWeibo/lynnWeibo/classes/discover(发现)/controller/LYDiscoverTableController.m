//
//  LYDiscoverTableController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYDiscoverTableController.h"
#import "LYSearchBar.h"

@interface LYDiscoverTableController ()

@end

@implementation LYDiscoverTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LYLog(@"LYProfileTableController--viewDidLoad");
    
    LYSearchBar * searchBar = [LYSearchBar searchBar];
    
    searchBar.width = 400;
    
    searchBar.height = 30;
    
    //设置成导航栏
    self.navigationItem.titleView = searchBar;
    
    
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
    static NSString * identifier = @"discoverCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Discover -- line:%ld", (long)indexPath.row];
    
    return cell;
}

@end
