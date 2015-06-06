//
//  LYMessageTableController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYMessageTableController.h"

@interface LYMessageTableController ()

@end

@implementation LYMessageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //appearence已经设置好了
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(writeMessage)];
    
    //最初设置为不可用
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    LYLog(@"LYMessageTableController--viewDidLoad");
    
}

-(void)writeMessage
{
    LYLog(@"%s", __func__);
    //self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"messageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Message -- line -- %ld", (long)indexPath.row];
    
    return cell;
}


@end
