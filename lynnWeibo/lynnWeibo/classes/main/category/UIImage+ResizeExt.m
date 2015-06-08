//
//  UIImage+ResizeExt.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "UIImage+ResizeExt.h"

@implementation UIImage (ResizeExt)

+(UIImage *)resizedImage:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

@end
