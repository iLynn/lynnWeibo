//
//  UIBarButtonItem+ButtonImageExt.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "UIBarButtonItem+ButtonImageExt.h"

@implementation UIBarButtonItem (ButtonImageExt)

+ (UIBarButtonItem *)buttonItemWithImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTarget:(id)target andAction:(SEL)action
{
    UIButton * btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
