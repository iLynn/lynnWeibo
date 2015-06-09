//
//  LYIntroController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYIntroController.h"
#import "LYTabBarController.h"

#define LYIntroImagesCount 4

@interface LYIntroController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl * pageControl;

@end

@implementation LYIntroController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}


/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i < LYIntroImagesCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
        //图片自动匹配屏幕
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];

        imageView.image = [UIImage imageNamed:name];
        
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == LYIntroImagesCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(LYIntroImagesCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    // 不允许弹簧属性（拖不动）
    scrollView.bounces = NO;
    scrollView.backgroundColor = LYColor(246, 246, 246);
    
}


/**
 *  设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
    // 2.添加分享按钮
    [self setupShareButton:imageView];
}

/**
 *  添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.x = self.view.width * 0.5 - shareButton.width/2;
    shareButton.y = self.view.height * 0.6;
    
    // 4.设置间距
    // titleEdgeInsets : 切掉按钮内部UILabel的内容
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

/**
 分享
 */
- (void)share:(UIButton *)shareButton
{
    //默认是未选中，每次点击就切换一下
    shareButton.selected = !shareButton.isSelected;
}


/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.x = self.view.width * 0.5 - startButton.width/2;
    startButton.y = self.view.height * 0.7;
    
    // 4.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示主控制器（HMTabBarController）
    LYTabBarController *vc = [[LYTabBarController alloc] init];
    
    // 切换控制器：直接切换而不用push和modal的原因是：modal不能做到内存优化，push不能优化且statusbar很难隐藏
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;

}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    //一定要给页面总数，不然page control显示不出来
    pageControl.numberOfPages = LYIntroImagesCount;
    pageControl.x = self.view.width * 0.5 - pageControl.width/2;
    pageControl.y = self.view.height * 0.9;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = LYColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = LYColor(189, 189, 189);
    self.pageControl = pageControl;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    
    // 设置页码：过半就算下一页
    self.pageControl.currentPage = (int)(doublePage + 0.5);
}



@end
