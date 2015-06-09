//
//  LYPopMenuView.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYPopMenuView;

/**
 枚举：箭头尖尖所在的位置
 */
typedef enum {
    LYPopMenuViewArrowPositionCenter = 0,
    LYPopMenuViewArrowPositionLeft = 1,
    LYPopMenuViewArrowPositionRight = 2
} LYPopMenuViewArrowPosition;


@protocol LYPopMenuViewDelegate <NSObject>

@optional
- (void)popMenuViewDidDismissed:(LYPopMenuView *)popMenuView;

@end

@interface LYPopMenuView : UIView

@property (nonatomic, weak) id<LYPopMenuViewDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) LYPopMenuViewArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuViewWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showViewInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end
