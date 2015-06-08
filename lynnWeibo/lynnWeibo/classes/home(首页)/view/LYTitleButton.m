//
//  LYTitleButton.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYTitleButton.h"

@implementation LYTitleButton

+(instancetype)titleButton
{
    return [[self alloc]init];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        
        //内部文字靠右对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = LYNavigationFont;
        [self setTitleColor:LYNavigationColor forState:UIControlStateNormal];
        
    }
    return self;
}

/**
 *  重写方法，设置图片的位置
 *
 *  @param contentRect 整个button的frame
 *
 *  @return 图片的frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = imageH;
    CGFloat imageX = contentRect.size.width - imageW;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  重写方法，设置文字的位置
 *
 *  @param contentRect 整个button的frame
 *
 *  @return 文字的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = contentRect.size.width - titleH;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
