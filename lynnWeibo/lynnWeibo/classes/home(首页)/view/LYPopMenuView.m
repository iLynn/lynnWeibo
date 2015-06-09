//
//  LYPopMenuView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYPopMenuView.h"

@interface LYPopMenuView()

@property (nonatomic, strong) UIView * contentView;
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton * coverBtn;
/**
 *  容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIImageView * containerImage;

@end

@implementation LYPopMenuView

#pragma mark - 初始化方法

+ (instancetype)popMenuViewWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init])
    {
        self.contentView = contentView;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        /** 添加菜单内部的2个子控件 **/
        
        // 添加一个遮盖按钮，盖住窗口内的其他区域
        UIButton * coverBtn = [[UIButton alloc] init];
        // 透明色
        coverBtn.backgroundColor = [UIColor clearColor];
        // 点击事件的响应
        [coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:coverBtn];
        
        self.coverBtn = coverBtn;
        
        
        // 添加带箭头的菜单图片
        UIImageView * containerImage = [[UIImageView alloc] init];
        
        containerImage.userInteractionEnabled = YES;
        
        containerImage.image = [UIImage resizedImage:@"popover_background"];
        
        [self addSubview:containerImage];
        
        self.containerImage = containerImage;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //遮盖按钮的大小就是整个屏幕的大小
    self.coverBtn.frame = self.bounds;
}

#pragma mark - 点击遮盖按钮（屏蔽区域）

- (void)coverBtnClick
{
    [self dismiss];
}

#pragma mark - 公共方法

- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground)
    {
        self.coverBtn.backgroundColor = [UIColor blackColor];
        self.coverBtn.alpha = 0.2;
    }
    else
    {
        self.coverBtn.backgroundColor = [UIColor clearColor];
        self.coverBtn.alpha = 1.0;
    }

}

- (void)setArrowPosition:(LYPopMenuViewArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    
    switch (arrowPosition)
    {
        case LYPopMenuViewArrowPositionCenter:
            self.containerImage.image = [UIImage resizedImage:@"popover_background"];
            break;
            
        case LYPopMenuViewArrowPositionLeft:
            self.containerImage.image = [UIImage resizedImage:@"popover_background_left"];
            break;
            
        case LYPopMenuViewArrowPositionRight:
            self.containerImage.image = [UIImage resizedImage:@"popover_background_right"];
            break;
    }
}

- (void)setBackground:(UIImage *)background
{
    self.containerImage.image = background;
}

- (void)showViewInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.containerImage.frame = rect;
    [self.containerImage addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.containerImage.width - leftMargin - rightMargin;
    self.contentView.height = self.containerImage.height - topMargin - bottomMargin;
    
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuViewDidDismissed:)])
    {
        [self.delegate popMenuViewDidDismissed:self];
    }
    
    [self removeFromSuperview];
}

@end
