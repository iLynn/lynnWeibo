//
//  LYSearchBar.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYSearchBar.h"

@implementation LYSearchBar

+(instancetype)searchBar
{
    return [[self alloc]init];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置背景
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        
        //设置文字垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //创建“搜索”图片的视图
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        //设置图片的大小
        leftView.size = CGSizeMake(30, 30);
        
        //图片居中显示
        leftView.contentMode = UIViewContentModeCenter;
        
        //搜索视图设置为searchBar的左视图
        self.leftView = leftView;
        
        //显示右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //显示左边的视图一直显示
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

@end
