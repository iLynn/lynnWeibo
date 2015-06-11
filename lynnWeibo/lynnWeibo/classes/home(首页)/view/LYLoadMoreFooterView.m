//
//  LYLoadMoreFooterView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/11.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYLoadMoreFooterView.h"

@interface LYLoadMoreFooterView()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation LYLoadMoreFooterView

+(id)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (void)beginRefreshing
{
    self.label.text = @"正在加载更多...";
    [self.indicator startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.label.text = @"上拉加载更多数据";
    [self.indicator stopAnimating];
    self.refreshing = NO;
}

@end
