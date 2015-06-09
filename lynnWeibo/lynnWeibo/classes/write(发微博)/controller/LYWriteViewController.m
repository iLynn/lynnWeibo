//
//  LYWriteViewController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYWriteViewController.h"

@interface LYWriteViewController ()

@end

@implementation LYWriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //appearence已经设置好了
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //最初设置为不可发送
#warning 此处颜色有点问题，不知原因
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    LYLog(@"LYMessageTableController--viewDidLoad");
    
}

/**
 *  取消
 */
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
-(void)send
{
    LYLog(@"send");
}

@end
