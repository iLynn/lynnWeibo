//
//  LYWritePhotosView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/11.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYWritePhotosView.h"

@implementation LYWritePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];

    //填充
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    // 一行的最大列数
    NSInteger maxColsPerRow = 4;
    
    // 每个图片之间的间距
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++)
    {
        // 行号
        int row = i / maxColsPerRow;
        // 列号
        int col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin) + margin;
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (UIImageView * imageView in self.subviews)
    {
        [array addObject:imageView.image];
    }
    return array;
}


@end
