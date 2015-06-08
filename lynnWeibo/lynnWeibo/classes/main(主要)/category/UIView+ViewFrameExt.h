//
//  UIView+ViewFrameExt.h
//  UI-day3
//
//  Created by qianfeng on 15-4-15.
//  Copyright (c) 2015年 李颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFrameExt)

//直接赋值坐标的x和y
@property(nonatomic, assign)CGFloat x;
@property(nonatomic, assign)CGFloat y;
//直接赋值坐标点(x,y)
@property(nonatomic, assign)CGPoint origin;

@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGSize size;


@end
