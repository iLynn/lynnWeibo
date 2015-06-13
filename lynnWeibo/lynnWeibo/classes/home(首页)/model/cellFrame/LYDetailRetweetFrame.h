//
//  LYDetailRetweetFrame.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYStatus;

@interface LYDetailRetweetFrame : NSObject

/** 昵称Frame */
@property (nonatomic, assign) CGRect nameFrame;

/** 正文Frame */
@property (nonatomic, assign) CGRect contentFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;


/** 根据内容，填充计算 */
@property (nonatomic, strong) LYStatus * retweetStatus;

@end
