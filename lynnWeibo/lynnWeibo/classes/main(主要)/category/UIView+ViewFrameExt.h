//
//  UIView+ViewFrameExt.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/7.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFrameExt)

//直接赋值view的point
@property(nonatomic, assign)CGFloat x;
@property(nonatomic, assign)CGFloat y;
@property(nonatomic, assign)CGPoint origin;

//直接赋值view的size
@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGSize size;

//通过中点定位view
@property(nonatomic, assign)CGFloat centerX;
@property(nonatomic, assign)CGFloat centerY;

@end
