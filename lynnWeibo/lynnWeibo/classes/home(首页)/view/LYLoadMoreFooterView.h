//
//  LYLoadMoreFooterView.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/11.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLoadMoreFooterView : UIView

+(id)footer;

- (void)beginRefreshing;

- (void)endRefreshing;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

@end
