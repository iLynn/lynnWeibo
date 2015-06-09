//
//  UIView+ViewFrameExt.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "UIView+ViewFrameExt.h"

@implementation UIView (ViewFrameExt)

//重写set方法，使得可以只写point，不再写size
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    
    self.frame = rect;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    
    self.frame = rect;
}

- (void)setOrigin:(CGPoint)origin
{
    //self.origin.x与origin.x是完全不一样的！
    //前者是自己最初的frame坐标的x，也就是原本的位置；后者是传进来的坐标值里的x
    [self setX:origin.x];
    [self setY:origin.y];
}

//分别写宽度和高度(暂时用不上，get方法更重要)
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    
    self.frame = rect;
}

- (void)setSize:(CGSize)size
{
    [self setWidth:size.width];
    [self setHeight:size.height];
}


//重写所有的get方法
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGSize)size
{
    return self.frame.size;
}


- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end







