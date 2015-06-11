//
//  LYWritePhotosView.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/11.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYWritePhotosView : UIView

/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)images;

@end
