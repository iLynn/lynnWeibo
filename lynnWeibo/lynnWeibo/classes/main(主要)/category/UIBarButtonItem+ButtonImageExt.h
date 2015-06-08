//
//  UIBarButtonItem+ButtonImageExt.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ButtonImageExt)

+ (UIBarButtonItem *)buttonItemWithImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTarget:(id)target andAction:(SEL)action;

@end
