//
//  LYTabBar.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTabBar;

@protocol LYTabBarDelegate <NSObject>

-(void)tabBarDidClickPlusButton:(LYTabBar *)tabBar;

@end

@interface LYTabBar : UITabBar

@property (nonatomic, strong)id<LYTabBarDelegate> lydelegate;

@end
