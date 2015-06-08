//
//  UIImage+ResizeExt.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeExt)

/**
 *  根据图片名，返回一张可以自由拉伸的图片
 *
 *  @param imageName 图片名
 *
 *  @return 返回一张图片
 */
+(UIImage *)resizedImage:(NSString *)imageName;

@end
