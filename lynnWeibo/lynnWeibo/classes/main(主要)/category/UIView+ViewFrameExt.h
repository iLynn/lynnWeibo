//
//  UIView+ViewFrameExt.h
//  UI-day3
//
//  Created by qianfeng on 15-4-15.
//  Copyright (c) 2015年 李颖. All rights reserved.
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
